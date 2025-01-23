require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

# Prepare an Array of previous messages
message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant."
  }
]

inquiry = ""

while inquiry != "bye"
  puts "Hello! How can I help you today?"
  puts "-" * 50

  inquiry = gets.chomp

  if (inquiry != "bye")
    message_list.push({ "role" => "user", "content" => inquiry })

    api_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
      }
    )

    choices = api_response.fetch("choices")
    first_choice = choices.at(0)
    message = first_choice.fetch("message")
    response = message["content"]

    puts response
    puts "-" * 50

    message_list.push({ "role" => "assistant", "content" => response })
  end

end
