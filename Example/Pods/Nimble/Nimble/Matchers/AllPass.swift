import Foundation

public func allPass<T,U where U: SequenceType, U.Generator.Element == T>
    (passFunc: (T?) -> Bool) -> NonNilMatcherFunc<U> {
        return allPass("pass a condition", passFunc: passFunc)
}

public func allPass<T,U where U: SequenceType, U.Generator.Element == T>
    (passName:String, passFunc: (T?) -> Bool) -> NonNilMatcherFunc<U> {
        return createAllPassMatcher() {
            expression, failureMessage in
            failureMessage.postfixMessage = passName
            return passFunc(expression.evaluate())
        }
}

public func allPass<U,V where U: SequenceType, V: Matcher, U.Generator.Element == V.ValueType>
    (matcher: V) -> NonNilMatcherFunc<U> {
        return createAllPassMatcher() {matcher.matches($0, failureMessage: $1)}
}

private func createAllPassMatcher<T,U where U: SequenceType, U.Generator.Element == T>
    (elementEvaluator:(Expression<T>, FailureMessage) -> Bool) -> NonNilMatcherFunc<U> {
        return NonNilMatcherFunc { actualExpression, failureMessage in
            failureMessage.actualValue = nil
            if let actualValue = actualExpression.evaluate() {
                for currentElement in actualValue {
                    let exp = Expression(
                        expression: {currentElement}, location: actualExpression.location)
                    if !elementEvaluator(exp, failureMessage) {
                        failureMessage.postfixMessage =
                            "all \(failureMessage.postfixMessage),"
                            + " but failed first at element <\(stringify(currentElement))>"
                            + " in <\(stringify(actualValue))>"
                        return false
                    }
                }
                failureMessage.postfixMessage = "all \(failureMessage.postfixMessage)"
            } else {
                failureMessage.postfixMessage = "all pass (use beNil() to match nils)"
                return false
            }
            
            return true
        }
}

extension NMBObjCMatcher {
    public class func allPassMatcher(matcher: NMBObjCMatcher) -> NMBObjCMatcher {
        return NMBObjCMatcher(canMatchNil: false) { actualExpression, failureMessage in
            let location = actualExpression.location
            let actualValue = actualExpression.evaluate()
            var nsObjects = [NSObject]()
            
            var collectionIsUsable = true
            if let value = actualValue as? NSFastEnumeration {
                let generator = NSFastGenerator(value)
                while let obj:AnyObject = generator.next() {
                    if let nsObject = obj as? NSObject {
                        nsObjects.append(nsObject)
                    } else {
                        collectionIsUsable = false
                        break
                    }
                }
            } else {
                collectionIsUsable = false
            }
            
            if !collectionIsUsable {
                failureMessage.postfixMessage =
                  "allPass only works with NSFastEnumeration (NSArray, NSSet, ...) of NSObjects"
                failureMessage.expected = ""
                failureMessage.to = ""
                return false
            }
            
            let expr = Expression(expression: ({ nsObjects }), location: location)
            let elementEvaluator: (Expression<NSObject>, FailureMessage) -> Bool = {
                expression, failureMessage in
                return matcher.matches(
                    {expression.evaluate()}, failureMessage: failureMessage, location: expr.location)
            }
            return createAllPassMatcher(elementEvaluator).matches(
                expr, failureMessage: failureMessage)
        }
    }
}
