
require 'json'
require "uri"
require "net/http"

class IMBtracking

  def self.getToken(username,password)
    auth = `curl -X POST -k -H 'Content-Type: application/json' -i 'https://services.usps.com/oauth/authenticate' --data '{"username": "#{username}","password": "#{password}","grant_type": "authorization","response_type": "token","scope": "user.info.ereg,iv1.apis","client_id": "687b8a36-db61-42f7-83f7-11c79bf7785e"}'`

    firstSplit = auth.split("\"access_token\":\"", -1)[1]
    token = firstSplit.split("\",\"expires_in\"", -1)[0]

    return token
  end

  def self.trackingByMID(token, mid, serial)

    bar = `curl -X GET -k -H 'Authorization: Bearer #{token}' -i 'https://iv.usps.com/ivws_api/informedvisapi/api/mt/get/piece/mid/#{mid}/serial/#{serial}'`

    #
    initialSplit = bar.split('barcodes',-1)[1]
    #
    # p "hello"
    imbVal = initialSplit.split('"', -1)[2]

    return self.trackByIMB(token, imbVal)


  end

  def self.trackByIMB(token, imb)
    track = `curl -X GET -k -H 'Authorization: Bearer #{token}' -i 'https://iv.usps.com/ivws_api/informedvisapi/api/mt/get/piece/imb/#{imb}'`

    json = track.split("mode=block\r\n\r\n", -1)[1]


    parsed = JSON.parse(json)

    return parsed["data"]
  end


end
# response.code
# response.body
