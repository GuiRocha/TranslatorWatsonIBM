require "json"
require "ibm_watson/authenticators"
require "ibm_watson/language_translator_v3"
include IBMWatson
class WatsonTranslator

    def initialize
        
        unless File.exists?("config")
            puts "Arquivo config não encontrado em 'config'"
            exit
        end

        @config = {}
        configurations = File.open("config", 'r').read.split("\n")
        configurations.each{|c| @config[c.split("=")[0]] = c.split("=")[1]}

        unless @config['url']
            puts "url não configurado!"
            exit
        else
            puts "url: #{@config['url']}"
        end

        unless @config['apikey']
            puts "apikey não configurado!"
            exit
        else
            puts "apikey: #{@config['apikey']}"
        end
authenticator = Authenticators::IamAuthenticator.new(
  apikey: "#{@config['apikey']}"
)

language_translator = LanguageTranslatorV3.new(
  version: "2018-05-01",
  authenticator: authenticator
)
language_translator.service_url = "#{@config['url']}"

translation = language_translator.translate(
  text: "hello, my name is Guilherme Rocha, I'm a developer Ruby",
  model_id: "en-fr"
  
)
translation01 = language_translator.translate(
    text: "hello, my name is Guilherme Rocha, I'm a developer Ruby",
    model_id: "en-pt"
    
  )
puts JSON.pretty_generate(translation01.result)
puts JSON.pretty_generate(translation.result)
end
end

is = WatsonTranslator.new