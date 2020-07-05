//
//  Defaults.swift
//  Evain
//
//  Created by Jatin on 2020/07/02.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    var launched: DefaultsKey<Bool> { .init("launched", defaultValue: false) }
    var signature: DefaultsKey<String> { .init("signature", defaultValue: "") }
    var verifyFp: DefaultsKey<String> { .init("verifyFp", defaultValue: "") }
}
