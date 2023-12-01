// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.
import ballerina/jballerina.java;
import ballerina/persist;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerinax/persist.sql as psql;

const IDENTITY_REQUEST = "identityrequests";
const GRAMA_DIVISION = "gramadivisions";

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final mysql:Client dbClient;

    private final map<psql:SQLClient> persistClients;

    private final record {|psql:SQLMetadata...;|} & readonly metadata = {
        [IDENTITY_REQUEST] : {
            entityName: "IdentityRequest",
            tableName: "IdentityRequest",
            fieldMetadata: {
                id: {columnName: "id"},
                initials_fullname: {columnName: "initials_fullname"},
                fullname: {columnName: "fullname"},
                NIC: {columnName: "NIC"},
                gender: {columnName: "gender"},
                contact_num: {columnName: "contact_num"},
                email: {columnName: "email"},
                address: {columnName: "address"},
                DOB: {columnName: "DOB"},
                applied_date: {columnName: "applied_date"},
                approved_by: {columnName: "approved_by"},
                status: {columnName: "status"},
                grama_divisionId: {columnName: "grama_divisionId"},
                "grama_division.id": {relation: {entityName: "grama_division", refField: "id"}},
                "grama_division.province": {relation: {entityName: "grama_division", refField: "province"}},
                "grama_division.district": {relation: {entityName: "grama_division", refField: "district"}},
                "grama_division.DS_division": {relation: {entityName: "grama_division", refField: "DS_division"}},
                "grama_division.GN_division": {relation: {entityName: "grama_division", refField: "GN_division"}}
            },
            keyFields: ["id"],
            joinMetadata: {grama_division: {entity: GramaDivision, fieldName: "grama_division", refTable: "GramaDivision", refColumns: ["id"], joinColumns: ["grama_divisionId"], 'type: psql:ONE_TO_MANY}}
        },
        [GRAMA_DIVISION] : {
            entityName: "GramaDivision",
            tableName: "GramaDivision",
            fieldMetadata: {
                id: {columnName: "id"},
                province: {columnName: "province"},
                district: {columnName: "district"},
                DS_division: {columnName: "DS_division"},
                GN_division: {columnName: "GN_division"},
                "identityrequest[].id": {relation: {entityName: "identityrequest", refField: "id"}},
                "identityrequest[].initials_fullname": {relation: {entityName: "identityrequest", refField: "initials_fullname"}},
                "identityrequest[].fullname": {relation: {entityName: "identityrequest", refField: "fullname"}},
                "identityrequest[].NIC": {relation: {entityName: "identityrequest", refField: "NIC"}},
                "identityrequest[].gender": {relation: {entityName: "identityrequest", refField: "gender"}},
                "identityrequest[].contact_num": {relation: {entityName: "identityrequest", refField: "contact_num"}},
                "identityrequest[].email": {relation: {entityName: "identityrequest", refField: "email"}},
                "identityrequest[].address": {relation: {entityName: "identityrequest", refField: "address"}},
                "identityrequest[].DOB": {relation: {entityName: "identityrequest", refField: "DOB"}},
                "identityrequest[].applied_date": {relation: {entityName: "identityrequest", refField: "applied_date"}},
                "identityrequest[].approved_by": {relation: {entityName: "identityrequest", refField: "approved_by"}},
                "identityrequest[].status": {relation: {entityName: "identityrequest", refField: "status"}},
                "identityrequest[].grama_divisionId": {relation: {entityName: "identityrequest", refField: "grama_divisionId"}}
            },
            keyFields: ["id"],
            joinMetadata: {identityrequest: {entity: IdentityRequest, fieldName: "identityrequest", refTable: "IdentityRequest", refColumns: ["grama_divisionId"], joinColumns: ["id"], 'type: psql:MANY_TO_ONE}}
        }
    };

    public isolated function init() returns persist:Error? {
        mysql:Client|error dbClient = new (host = host, user = user, password = password, database = database, port = port, options = connectionOptions);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {
            [IDENTITY_REQUEST] : check new (dbClient, self.metadata.get(IDENTITY_REQUEST), psql:MYSQL_SPECIFICS),
            [GRAMA_DIVISION] : check new (dbClient, self.metadata.get(GRAMA_DIVISION), psql:MYSQL_SPECIFICS)
        };
    }

    isolated resource function get identityrequests(IdentityRequestTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get identityrequests/[string id](IdentityRequestTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post identityrequests(IdentityRequestInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(IDENTITY_REQUEST);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from IdentityRequestInsert inserted in data
            select inserted.id;
    }

    isolated resource function put identityrequests/[string id](IdentityRequestUpdate value) returns IdentityRequest|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(IDENTITY_REQUEST);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/identityrequests/[id].get();
    }

    isolated resource function delete identityrequests/[string id]() returns IdentityRequest|persist:Error {
        IdentityRequest result = check self->/identityrequests/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(IDENTITY_REQUEST);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get gramadivisions(GramaDivisionTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get gramadivisions/[string id](GramaDivisionTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post gramadivisions(GramaDivisionInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(GRAMA_DIVISION);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from GramaDivisionInsert inserted in data
            select inserted.id;
    }

    isolated resource function put gramadivisions/[string id](GramaDivisionUpdate value) returns GramaDivision|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(GRAMA_DIVISION);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/gramadivisions/[id].get();
    }

    isolated resource function delete gramadivisions/[string id]() returns GramaDivision|persist:Error {
        GramaDivision result = check self->/gramadivisions/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(GRAMA_DIVISION);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    remote isolated function queryNativeSQL(sql:ParameterizedQuery sqlQuery, typedesc<record {}> rowType = <>) returns stream<rowType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor"
    } external;

    remote isolated function executeNativeSQL(sql:ParameterizedQuery sqlQuery) returns psql:ExecutionResult|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor"
    } external;

    public isolated function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}

