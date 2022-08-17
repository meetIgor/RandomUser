//
//  User.swift
//  RandomUser
//
//  Created by igor s on 17.08.2022.
//

import Foundation

struct User {
    let results: [Person]
    let info: Info
    
    static func getUser(value: Any) -> User {
        let returnResult = User(
            results: [],
            info: Info(seed: "", results: 0, page: 0, version: "")
        )
        
        guard let user = value as? [String: Any] else { return returnResult }
        guard let infoData = user["info"] as? [String: Any] else { return returnResult }
        guard let resultsData = user["results"] as? [[String: Any]] else { return returnResult }
        
        return User(
            results: resultsData.compactMap { Person.getPerson(from: $0) },
            info: Info(infoData: infoData)
        )
    }
}

struct Info {
    let seed: String
    let results: Int
    let page: Int
    let version: String
    
    init(seed: String, results: Int, page: Int, version: String) {
        self.seed = seed
        self.results = results
        self.page = page
        self.version = version
    }
    
    init(infoData: [String: Any]) {
        seed = infoData["seed"] as? String ?? ""
        results = infoData["results"] as? Int ?? 0
        page = infoData["page"] as? Int ?? 0
        version = infoData["version"] as? String ?? ""
    }
}

struct Person {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: Dob
    let registered: Registration
    let phone: String
    let cell: String
    let id: Id
    let picture: Picture
    let nat: String
    
    static func getPerson(from value: [String: Any]) -> Person {
        let result = Person(
            gender: "", name: Name(nameData: [:]), location: Location.getLocation(from: [:]),
            email: "", login: Login(loginData: [:]), dob: Dob(dobData: [:]),
            registered: Registration(regData: [:]), phone: "", cell: "",
            id: Id(idData: [:]), picture: Picture(pictureData: [:]), nat: ""
        )
        
        guard
            let nameData = value["name"] as? [String: Any],
            let locationData = value["location"] as? [String: Any],
            let loginData = value["login"] as? [String: Any],
            let dobData = value["dob"] as? [String: Any],
            let regData = value["registered"] as? [String: Any],
            let idData = value["id"] as? [String: Any],
            let pictureData = value["picture"] as? [String: Any]
        else { return result }
        
        let name = Name(nameData: nameData)
        let location = Location.getLocation(from: locationData)
        let login = Login(loginData: loginData)
        let dob = Dob(dobData: dobData)
        let registered = Registration(regData: regData)
        let id = Id(idData: idData)
        let picture = Picture(pictureData: pictureData)
        
        let gender = value["gender"] as? String ?? ""
        let email = value["email"] as? String ?? ""
        let phone = value["phone"] as? String ?? ""
        let cell = value["cell"] as? String ?? ""
        let nat = value["nat"] as? String ?? ""
        
        return Person(
            gender: gender, name: name, location: location, email: email,
            login: login, dob: dob, registered: registered, phone: phone,
            cell: cell, id: id, picture: picture, nat: nat
        )
    }
}

struct Name {
    let title: String
    let first: String
    let last: String
    
    init(nameData: [String: Any]) {
        title = nameData["title"] as? String ?? ""
        first = nameData["first"] as? String ?? ""
        last = nameData["last"] as? String ?? ""
    }
}

struct Location {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Int
    let coordinates: Coordinates
    let timezone: Timezone
    
    static func getLocation(from locationData: [String: Any]) -> Location {
        let result = Location(
            street: Street(streetData: [:]), city: "", state: "",
            country: "", postcode: 0, coordinates: Coordinates(coordinatesData: [:]),
            timezone: Timezone(tzoneData: [:])
        )
        
        guard
            let streetData = locationData["street"] as? [String: Any],
            let coordinatesData = locationData["coordinates"] as? [String: Any],
            let timezoneData = locationData["timezone"] as? [String: Any]
        else { return result }
        
        let street = Street(streetData: streetData)
        let coordinates = Coordinates(coordinatesData: coordinatesData)
        let timezone = Timezone(tzoneData: timezoneData)
        
        let city = locationData["city"] as? String ?? ""
        let state = locationData["state"] as? String ?? ""
        let country = locationData["country"] as? String ?? ""
        let postcode = locationData["postcode"] as? Int ?? 0
        
        return Location(
            street: street, city: city, state: state, country: country,
            postcode: postcode, coordinates: coordinates, timezone: timezone
        )
    }
}

struct Street {
    let number: Int
    let name: String
    
    init(streetData: [String: Any]) {
        number = streetData["number"] as? Int ?? 0
        name = streetData["name"] as? String ?? ""
    }
}

struct Coordinates {
    let latitude: String
    let longitude: String
    
    init(coordinatesData: [String: Any]) {
        latitude = coordinatesData["latitude"] as? String ?? ""
        longitude = coordinatesData["longitude"] as? String ?? ""
    }
}

struct Timezone {
    let offset: String
    let description: String
    
    init(tzoneData: [String: Any]) {
        offset = tzoneData["offset"] as? String ?? ""
        description = tzoneData["description"] as? String ?? ""
    }
}

struct Login {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
    
    init(loginData: [String: Any]) {
        uuid = loginData["uuid"] as? String ?? ""
        username = loginData["username"] as? String ?? ""
        password = loginData["password"] as? String ?? ""
        salt = loginData["salt"] as? String ?? ""
        md5 = loginData["md5"] as? String ?? ""
        sha1 = loginData["sha1"] as? String ?? ""
        sha256 = loginData["sha256"] as? String ?? ""
    }
}

struct Dob {
    let date: String
    let age: Int
    
    init(dobData: [String: Any]) {
        date = dobData["date"] as? String ?? ""
        age = dobData["age"] as? Int ?? 0
    }
}

struct Registration {
    let date: String
    let age: Int
    
    init(regData: [String: Any]) {
        date = regData["date"] as? String ?? ""
        age = regData["age"] as? Int ?? 0
    }
}

struct Id {
    let name: String
    let value: String
    
    init(idData: [String: Any]) {
        name = idData["name"] as? String ?? ""
        value = idData["value"] as? String ?? ""
    }
}

struct Picture {
    let large: String
    let medium: String
    let thumbnail: String
    
    init(pictureData: [String: Any]) {
        large = pictureData["large"] as? String ?? ""
        medium = pictureData["medium"] as? String ?? ""
        thumbnail = pictureData["thumbnail"] as? String ?? ""
    }
}

//User Description
extension User {
    var description: String {
        var result =
        """
        INFO
            seed: \(info.seed)
            results: \(info.results)
            page: \(info.page)
            version: \(info.version)
        
        RESULTS:
        """
        
        for person in results {
            result +=
        """
            
            gender: \(person.gender)
            NAME:
                title: \(person.name.title)
                first: \(person.name.first)
                last: \(person.name.last)
            LOCATION:
                STREET:
                    number: \(person.location.street.name)
                    name: \(person.location.street.number)
                city: \(person.location.city)
                state: \(person.location.state)
                country: \(person.location.country)
                postcode: \(person.location.postcode)
                COORDINATES:
                        latitude: \(person.location.coordinates.latitude)
                        longtitude: \(person.location.coordinates.longitude)
                TIMEZONE:
                        offset: \(person.location.timezone.offset)
                        description: \(person.location.timezone.description)
            email: \(person.email)
            LOGIN:
                uuid: \(person.login.uuid)
                username:\(person.login.username)
                password \(person.login.password)
                salt: \(person.login.salt)
                md5: \(person.login.md5)
                sha1: \(person.login.sha1)
                sha256: \(person.login.sha256)
            DOB:
                dat:\(person.dob.date)
                age: \(person.dob.age)
            REGISTERED:
                date: \(person.registered.date)
                date: \(person.registered.date)
            phone: \(person.phone)
            cell:  \(person.cell)
            ID:
                name: \(person.id.name)
                value: \(person.id.value)
            PICTURE:
                large: \(person.picture.large)
                medium: \(person.picture.medium)
                thumbnail: \(person.picture.thumbnail)
            nat: \(person.nat)
                    
        """
        }
        return result
    }
}
