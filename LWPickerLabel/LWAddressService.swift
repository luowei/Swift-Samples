//
//  LWAddressService.swift
//  ACERepair
//
//  Created by luowei on 16/8/4.
//  Copyright © 2016年 2345.com. All rights reserved.
//

import UIKit

class LWAddress {
    var ownId: String
    var name: String
    var superId: String

    init(ownId: String, name: String, superId: String) {
        self.ownId = ownId
        self.name = name
        self.superId = superId
    }
}


enum SQLiteError: ErrorType {
    case OpenDatabase(message:String)
    case Prepare(message:String)
    case Step(message:String)
    case Bind(message:String)
}

class LWAddressService {
    private let dbPointer: COpaquePointer

    static func open() throws -> LWAddressService? {
        var db: COpaquePointer = nil
        
        guard let path = NSBundle.mainBundle().pathForResource("app_address", ofType: "sqlite") as String? else{
            //throw SQLiteError.OpenDatabase(message: "Address db not found")
            print("Address db not found")
            return nil
        }
        
        if sqlite3_open(path, &db) == SQLITE_OK {
            return LWAddressService(dbPointer: db) as LWAddressService?
        } else {
            defer {
                if db != nil {
                    sqlite3_close(db)
                }
            }

            if let message = String.fromCString(sqlite3_errmsg(db)) {
                //throw SQLiteError.OpenDatabase(message: message)
                print(message)
                return nil
            } else {
                //throw SQLiteError.OpenDatabase(message: "No error message provided from sqlite.")
                print("No error message provided from sqlite.")
                return nil
            }
        }
    }

    private init(dbPointer: COpaquePointer) {
        self.dbPointer = dbPointer
    }

    deinit {
        sqlite3_close(dbPointer)
    }

    private var errorMessage: String {
        if let errorMessage = String.fromCString(sqlite3_errmsg(dbPointer)) {
            return errorMessage
        } else {
            return "No error message provided from sqlite."
        }
    }
}


//Preparing Statements

extension LWAddressService {
    func prepareStatement(sql: String) throws -> COpaquePointer {
        var statement: COpaquePointer = nil
        guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.Prepare(message: errorMessage)
        }

        return statement
    }
}

//read

extension LWAddressService {
    func address(id: String) -> LWAddress? {
        let querySql = "SELECT * FROM address WHERE ownId = '\(id)'"
        return self.queryOne(querySql)
    }
    
    func superAddress(id:String) -> LWAddress? {
        let querySql = "SELECT * FROM address WHERE superId = '\(id)'"
        return self.queryOne(querySql)
    }
    
    func queryOne(sql: String) -> LWAddress? {
        
        guard let statement = try? prepareStatement(sql) else {
            return nil
        }
        
        defer {
            sqlite3_finalize(statement)
        }
        
//        guard let param = id as String? where sqlite3_bind_text(statement, 1, param, -1, nil) == SQLITE_OK else {
//            return nil
//        }
        
        guard sqlite3_step(statement) == SQLITE_ROW else {
            return nil
        }
        
        let col1 = sqlite3_column_text(statement, 0)
        guard let ownId = String.fromCString(UnsafePointer<CChar>(col1)) else{
            return nil
        }
        
        let col2 = sqlite3_column_text(statement, 1)
        guard let name = String.fromCString(UnsafePointer<CChar>(col2)) else{
            return nil
        }
        
        let col3 = sqlite3_column_text(statement, 1)
        guard  let superId = String.fromCString(UnsafePointer<CChar>(col3)) else{
            return nil
        }
        
        return LWAddress(ownId: ownId, name: name, superId: superId)
    }

    func provinceList() -> [LWAddress]? {
        let querySql = "SELECT * FROM address_province"
        return self.list(querySql);
    }

    func cityList(provinceId: String) -> [LWAddress]? {
        let querySql = "SELECT * FROM address_city WHERE superId = '\(provinceId)'"
        return self.list(querySql);
    }

    func areaList(cityId: String) -> [LWAddress]? {
        let querySql = "SELECT * FROM address_area WHERE superId = '\(cityId)'"
        return self.list(querySql);
    }

    func townList(areaId: String) -> [LWAddress]? {
        let querySql = "SELECT * FROM address_town WHERE superId = '\(areaId)'"
        return self.list(querySql);
    }

    func list(sql: String) -> [LWAddress]? {
        var list = [LWAddress]()
        guard var statement = try? prepareStatement(sql) else {
            return nil
        }

        defer {
            sqlite3_finalize(statement)
        }
        
//        if id != nil {
//            guard let param = id as String? where sqlite3_bind_text(statement, 1, param, -1, nil) == SQLITE_OK else {
//                return nil
//            }
//        }

        

//        guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else{
//            guard let errmsg = String.fromCString(sqlite3_errmsg(dbPointer)) as String? else{ return nil }
//            SQLiteError.Prepare(message: errmsg)
//            return nil
//        }

        while sqlite3_step(statement) == SQLITE_ROW {
            let col1 = sqlite3_column_text(statement, 0)
            guard let ownId = String.fromCString(UnsafePointer<CChar>(col1)) else{
                return nil
            }

            let col2 = sqlite3_column_text(statement, 1)
            guard let name = String.fromCString(UnsafePointer<CChar>(col2)) else{
                return nil
            }

            let col3 = sqlite3_column_text(statement, 2)
            guard  let superId = String.fromCString(UnsafePointer<CChar>(col3)) else{
                return nil
            }

            let addr = LWAddress(ownId: ownId, name: name, superId: superId)
            list.append(addr)
        }

        return list;
    }
}


