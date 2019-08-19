require 'google/apis/gmail_v1'
require 'google/apis/translate_v2'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'NARANJA TEST'.freeze
# CREDENTIALS_PATH = "email-credentials.json".freeze
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
PATH ='features/support/'.freeze
SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

# Initialize the API
Gmail = Google::Apis::GmailV1 # Alias the module

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize(credentials)
    credentials_path = "#{PATH}#{credentials}-gmail.json"
    token_path = "#{PATH}#{credentials}-token.yaml"
    client_id = Google::Auth::ClientId.from_file credentials_path
    token_store = Google::Auth::Stores::FileTokenStore.new file: token_path
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = 'default'
    credentials = authorizer.get_credentials user_id
    if credentials.nil?
        url = authorizer.get_authorization_url base_url: OOB_URI
        puts 'Open the following URL in the browser and enter the ' \
            "resulting code after authorization:\n" + url
        code = gets
        credentials = authorizer.get_and_store_credentials_from_code(user_id: user_id, code: code, base_url: OOB_URI)
    end
    credentials
end

def recevie_email(email, item_recovery)
    sleep 10
    service = Gmail::GmailService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize(GMAIL_ARCHIVES[email.to_sym])

    # Show the user's labels
    user_id = 'me'
    result = service.list_user_messages user_id
    puts 'Labels:'
    puts result.messages
    result.messages.each do |label|
        email = service.get_user_message user_id, label.id
        payload = email.payload
        headers = payload.headers
        from = headers.any? { |h| h.name == 'From' } ? headers.find { |h| h.name == 'From' }.value : ''
        body = payload.body.data if from.include? '@naranja.com'
        body = payload.parts.map { |part| part.body.data }.join if body.nil? && payload.parts.any?
        match = REGEX[item_recovery.to_sym].match(body)
        link = match.to_s.split(' ')
        # service.trash_user_message user_id, label.id waiting google liberation
        return link[0]
    end
end
