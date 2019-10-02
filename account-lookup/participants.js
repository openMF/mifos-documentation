const NodeCache = require('node-cache')
const participantsCache = new NodeCache()

class Participants {

  getParticipantsByTypeId(type, id) {
    let idMap = new Map()
    let response
    if (participantsCache.get(type)) {
      idMap = participantsCache.get(type)
      if (idMap.get(id)) {
        response = idMap.get(id)
      } else {
        response = []
      }
    } else {
      response = []
    }
    return response
  }

  createParticipantsByTypeAndId(type, id, fspId, currency, partySubIdOrType) {
    const record = {
      partyList: [
        {
          fspId: fspId,
          currency: currency || undefined,
          partySubIdOrType: partySubIdOrType || undefined
        }
      ]
    }
    let idMap = new Map()
    if (participantsCache.get(type)) {
      idMap = participantsCache.get(type)
      if (idMap.get(id)) {
        throw new Error(`ID:${id} already exists`)
      } else {
        idMap.set(id, record)
        participantsCache.set(type, idMap)
      }
    } else {
      idMap.set(id, record)
      participantsCache.set(type, idMap)
    }

    return record
  }

  updateParticipantsByTypeAndId(type, id, fspId, currency, partySubIdOrType) {
    let idMap
    if (participantsCache.get(type)) {
      idMap = participantsCache.get(type)
      if (idMap.get(id)) {
        const currentRecord = idMap.get(id)
        if (fspId && currentRecord.partyList[0].fspId !== fspId) {
          currentRecord.partyList[0].fspId = fspId
        }
        if (currency && currentRecord.partyList[0].currency !== currency) {
          currentRecord.partyList[0].currency = currency
        }
        if (partySubIdOrType && currentRecord.partyList[0].partySubIdOrType !== partySubIdOrType) {
          currentRecord.partyList[0].partySubIdOrType = partySubIdOrType
        }
        idMap.set(id, currentRecord)
        participantsCache.set(type, idMap)
      } else {
        throw new Error(`ID:${id} not found`)
      }
    } else {
      throw new Error(`Type:${type} not found`)
    }
  }

  deleteParticipantsByTypeAndId(type, id) {
    let idMap
    if (participantsCache.get(type)) {
      idMap = participantsCache.get(type)
      if (idMap.get(id)) {
        idMap.delete(id)
        participantsCache.set(type, idMap)
      } else {
        const errorObject = {
          errorCode: 2345,
          errorDescription: `ID:${id} not found`
        }
        histTimerEnd({ success: false, operation: 'deleteParticipants', source: request.headers['fspiop-source'], destination: request.headers['fspiop-destination'] })
        return h.response(buildErrorObject(errorObject, [])).code(400)
      }
    } else {
      throw new Error(`Type:${type} not found`)
    }
  }
}

module.exports = Participants