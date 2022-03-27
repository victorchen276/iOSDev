//
//  main.swift
//  WebScraper
//
//  Created by Chen Yue on 27/03/22.
//

import Foundation
import SwiftSoup

print("Hello, World!")

let content = try String(contentsOf: URL(string: "https://news.ycombinator.com/")!)
let doc: Document = try SwiftSoup.parse(content)

let table = try doc.select("table.itemlist").first()!
let rows = try table.select("tr")


let title = try rows.compactMap { row throws -> String? in
    let cells = try row.select("td.title")
    guard cells.count == 2, let link = try cells[1].select("a").first() else {
        return nil // wrong row
    }

    return try link.text()
}
debugPrint("title = \(title)")
