require 'sinatra'
require 'json'
require 'pry'
require 'byebug'
require 'awesome_print'

require 'dotenv'
Dotenv.load

post "/" do
  parsed_request = JSON.parse(request.body.read)
  recipient = parsed_request["request"]["intent"]["slots"]["Recipient"]["value"]
  recipient = if recipient.nil?
    'Sugarman Family'
  elsif recipient == 'everyone'
    ENV['FAMILY_GREETING']
  else
    recipient
  end

  # ap "<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>"
  # ap "saying hello to #{recipient}"
  # ap "<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>"

  {
    version: "1.0",
    response: {
      outputSpeech: {
        type: "SSML",
        ssml: "<speak>Hello #{recipient}</speak>"
      }
    }
  }.to_json
end