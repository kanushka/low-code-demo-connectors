# Demo Connector documentation
# This connector will cover (basic) structured type kinds like,
# array, tuple, map, record, inline record, closed record
#
# + token - Connector access token
# + url - Test url
@display {label: "Demo Connector Two"}
public client class Client {
    public string token;
    public string url;

    public isolated function init(string token, string url = "http://example.com/") returns error? {
        self.token = token;
        self.url = url;
    }

    # Get test message array.
    # without any display annotations
    #
    # + return - Test message array
    remote isolated function getMessages() returns string[] {
        return ["msg1", "msg2", "msg3"];
    }

    # Read test message.
    # with function level display annotation
    # this function will cover array, tuple input types
    #
    # + ids - Id list to read messages
    # + token - Credentials
    # + return - Tuple with message id and message or an error
    @display {label: "Read Message"}
    remote isolated function readMessage(int[] ids, [int, string] token = [0, ""]) returns [int, string]|error {
        return [10, "No message"];
    }

    # Send messages
    # with function level and parameter level display annotations
    # this will cover record and map input types
    #
    # + msgList - Message list with id and message
    # + auth - Credentials to authenticate broker
    # + return - Error or Map with message status
    @display {label: "Send Message"}
    remote isolated function sendMessage(
        @display {label: "Message List"} map<string> msgList,
        @display {label: "Credentials"} Auth auth) returns map<boolean|error>|error {

        map<boolean|error> m = {
            "x": true,
            "y": false,
            "z": error("Error")
        };
        return m;
    }

    # View messages
    #
    # + user - User data to get messages
    # + return - retunrn message map or nill
    remote isolated function viewMessage(User user) returns map<string>|() {
        return ();
    }

    # Update message with inline closed record parameter
    #
    # + id - Message id 
    # + message - Message contents
    # + return - Updated message
    remote isolated function updateMessage(int id,
        record {|string body; User sender?; User receiver;|} message) returns Message|error {
        Message newMsg = {
            body: message.body,
            sender: {
                id: 0,
                name: ""
            },
            receiver: message.receiver
        };

        return newMsg;
    }

    # Forward messages
    # Remote function with optional error return type
    #
    # + user - User data to forward messages
    # + message - Message info
    # + return - retunrn message map or nill
    remote isolated function forward(User user, Message message) returns Message|error? {
        Message newMsg = {
            body: message.body,
            sender: {
                id: 0,
                name: ""
            },
            receiver: message.receiver
        };

        return newMsg;
    }

    # Delete messages
    # Isolated function without remote access modifier
    #
    # + user - User data to get messages
    # + return - retunrn message map or nill
    isolated function deleteMessage(User user) returns map<string>|() {
        return ();
    }
}

# Auth Type
#
# + username - Username
# + password - Password  
public type Auth record {
    string username;
    string password;
};

# User Type with inline address record type
#
# + id - User id  
# + name - Username  
# + owner - Owner of the user  
# + address - Address 
public type User record {
    int id;
    string name;
    User owner?;

    record {|
        string homeNo;
        string street?;
        string city;
        string postalcode;
    |} address?;
};

# Message type
#
# + body - Mesage content 
# + sender - Sender  
# + receiver - Receiver
public type Message record {
    string body;
    User sender?;
    User receiver;
};
