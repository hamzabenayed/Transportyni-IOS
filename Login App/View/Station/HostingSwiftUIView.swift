//
//  HostingSwiftUIView.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 8/12/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import SwiftUI

class HostingSwiftUIView: UIHostingController<AffichageStationSwiftUIView>{
    required init?(coder aDecoder : NSCoder ) {
        super.init(coder: aDecoder ; rootView :AffichageStationSwiftUIView() )
    }
}

struct
