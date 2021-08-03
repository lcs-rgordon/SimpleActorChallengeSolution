//
//  ContentView.swift
//  SimpleActorChallengeSolution
//
//  Created by Russell Gordon on 2021-08-03.
//

import SwiftUI

actor SimpleTeam {
    var players: [String]
    init(initialPlayers: [String]) {
        self.players = initialPlayers
    }
    func transfer(player: String, to otherTeam: SimpleTeam) async {
        guard let index = players.firstIndex(of: player) else { return }
        players.remove(at: index)
        await otherTeam.receive(player)
    }
    func receive(_ player: String) {
        players.append(player)
    }
}
actor Player: Equatable {
    let id: Int
    var name: String
    var salary: Decimal
    init(id: Int, name: String, salary: Decimal) {
        self.id = id
        self.name = name
        self.salary = salary
    }
    func offerRaise(amount: Decimal) {
        guard amount > 0 else {
            print("That's it, I quit!")
            return
        }
        salary += amount
    }
    static func ==(lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
}
actor Team {
    var players: [Player]
    init(initialPlayers: [Player]) {
        self.players = initialPlayers
    }
    func transfer(player: Player, to otherTeam: Team) async {
        guard let index = players.firstIndex(of: player) else { return }
        players.remove(at: index)
        await otherTeam.receive(player)
    }
    func receive(_ player: Player) {
        players.append(player)
    }
}
    

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
