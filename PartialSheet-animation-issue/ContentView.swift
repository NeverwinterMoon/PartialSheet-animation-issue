//
//  ContentView.swift
//  PartialSheet-animation-issue
//
//  Created by Pavel Sorokin on 04.06.2020.
//  Copyright © 2020 NeverwinterMoon. All rights reserved.
//

import PartialSheet
import SwiftUI

struct ContentView: View {
  @EnvironmentObject var partialSheet: PartialSheetManager
  
  var body: some View {
    VStack {
      Button(
        action: {
          self.partialSheet.showPartialSheet {
            PartialSheetView()
          }
        },
        label: {
          Text("Show Partial Sheet")
        }
      )
    }
    .addPartialSheet()
  }
}

struct PartialSheetView: View {
  var body: some View {
    content
  }
  
  private var content: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(0 ..< 4) { _ in
        Row()
      }
    }
  }
}

struct Row: View {
  @State private var isLoading: Bool = true

  var body: some View {
    ZStack { content }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          self.isLoading = false
        }
    }
  }
  
  @ViewBuilder private var content: some View {
    if !isLoading {
      ZStack {
        Color.yellow

        Text("Loaded view")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(PartialSheetManager())
  }
}
