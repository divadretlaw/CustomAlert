//
//  DetailLabel.swift
//  Demo
//
//  Created by David Walter on 06.07.24.
//

import SwiftUI

struct DetailLabel: View {
    let title: String
    let detail: String?
    
    init(_ title: String, detail: String? = nil) {
        self.title = title
        self.detail = detail
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.body)
                .foregroundStyle(.primary)
            if let detail {
                Text(detail)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    List {
        DetailLabel("Hello", detail: "World")
    }
}
