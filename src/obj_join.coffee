_ = require 'underscore'

module.exports = {
  _hashJoin : (arr1, arr2, joinAttr)->
    jointObject = {}
    retVal = {}
    for object in arr1
      key = object["#{joinAttr}"]
      if not jointObject[key] 
        jointObject[key] = {} 
      jointObject[key] = _.extend(jointObject[key], object)
    
    for object in arr2
      key = object["#{joinAttr}"]
      if jointObject[key] 
        jointObject[key] = _.extend(jointObject[key], object)
        retVal.push( jointObject[key] )
    
    return retVal

  outerJoin : (mainArray, secArray, joinAttr)->
    hashJoinTable = @_hashJoin(mainArray, secArray, joinAttr)
    for i in ([0...(mainArray).length])
      if hashJoinTable[ mainArray[i]["#{joinAttr}"] ]
        mainArray[i] = hashJoinTable[ mainArray[i]["#{joinAttr}"] ]

    return mainArray      

  innerJoin : (leftArray, rightArray, joinAttr)->
    retVal = []
    hashJoinTable = @_hashJoin(leftArray, rightArray, joinAttr)
    for obj in hashJoinTable
      retVal.push obj

    return retVal

  leftOuterJoin : (arr1, arr2, joinAttr)->
    return @outerJoin(arr1, arr2, joinAttr)

  rightOuterJoin : (arr1, arr2, joinAttr)->
    return @outerJoin(arr2, arr1, joinAttr)

}