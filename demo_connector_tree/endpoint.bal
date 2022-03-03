# Demo Connector documentation
# This connector will cover (basic) structured type kinds like,
# array, tuple, map, record, inline record, closed record
#
# + credentials - Connector credentials
# + user - Test user info
@display {label: "Demo Connector Three"}
public client class Client {
    public Auth credentials;
    public User user;

    public isolated function init(Auth credentials, User user) returns error? {
        self.credentials = credentials;
        self.user = user;
    }

    # Get student list 
    # this function will handle stream return type
    #
    # + return - Student stream
    remote isolated function getStudents() returns stream<Student>|error {
        Student s1 = {id: 11, name: "George", score: 1.5};
        Student s2 = {id: 22, name: "Fonseka", score: 0.9};
        Student s3 = {id: 33, name: "David", score: 1.2};

        Student[] studentList = [s1, s2, s3];
        stream<Student> studentStream = studentList.toStream();
        return studentStream;
    }

    # Send message
    # this function will handle typedesc and union type
    #
    # + message - Message 
    # + receiver - Reciever  
    # + paylodType - Payload type
    # + return - Error or Map with message status
    remote isolated function sendMessage(string|xml|json message, Person receiver, TargetType paylodType) returns TargetType|error {
        return TargetType;
    }

    # Search messages
    #
    # + msg - Any content to search message  
    # + position - Position points (defaultable)
    # + return - retunrn message map or nill
    remote isolated function searchMessage(anydata msg, byte[] position = base16 `aeeecdefabcd12345567888822`) returns string|xml|json|() {
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

# Student type
# inclusion with User type
#
# + score - Field Description
type Student record {
    *User;
    float score;
};

# Person Object Type
#
# + name - Name
# + age - Age
# + parent - Parent
public type Person object {
    public string name;
    public int age;
    string address;

    public Person? parent;
};

# Payload Type
public type PayloadType string|xml|json|map<string>|map<json>|byte[]|record {| anydata...; |}|record {| anydata...;|}[];

# Tartget Type
public type TargetType typedesc<PayloadType>;