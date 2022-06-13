# Demo Connector documentation
# This connector will cover (basic) simple and sequance type kinds like,
# nil, boolean, int, float, decimal, string, xml
#
@display {label: "Demo Connector One"}
public client class Client {

    # Get test message.
    # without any display annotations
    #
    # + return - Test message or an error
    remote isolated function getMessage() returns string|error {
        return "Test Message";
    }

    # Read test message.
    # with function level display annotation
    # this function will cover int, float, decimal and boolean input types
    #
    # + id - message id
    # + fq - fq
    # + point - point
    # + bool - boolean
    # + return - boolean value of message read status
    @display {label: "Read Message"}
    remote isolated function readMessage(int id, float fq, decimal point, boolean bool) returns boolean {
        return true;
    }

    # Send message.
    # with function level and parameter level display annotations
    # this will cover record, string and xml input types
    #
    # + msg - Message to send
    # + body - Message body
    # + return - Error or nil
    @display {label: "Send Message"}
    remote isolated function sendMessage(
        @display {label: "Short Message"} string msg,
        @display {label: "XML Contents"} xml body = xml ``) returns error|() {
        return ();
    }

    # View test message.
    # with function level display annotation
    # this will conver int, float, decimal input types with default values
    #
    # + id - message id
    # + fq - fq
    # + bool - bool
    # + return - Test message or nill
    @display {label: "View Message"}
    remote isolated function viewMessage(int id, float fq = 1.23, boolean bool = false) returns string|() {
        return "Test Message";
    }

    # Test keywords in the parameter and
    # inside a object
    #
    # + 'client - Client id of the payment
    # + payment - Payment object
    # + return - Payment respones
    @display {label: "Test Keywords"}
    remote isolated function testKeyword(int 'client, Payment payment) returns PaymentResponse {
        return {
            note: (),
            amount: 0,
            'client,
            'order: 0
        };
    }
}

public type Payment record {
    int 'order;
    decimal amount;
    string? note;
};

public type PaymentResponse record {
    *Payment;
    int 'client;
};
