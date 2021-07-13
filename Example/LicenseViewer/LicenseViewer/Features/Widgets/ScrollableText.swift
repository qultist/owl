//
//  ScrollableText.swift
//  LicenseViewer
//
//  Created by Dominic Schmidt on 12.07.21.
//

import SwiftUI
import SnapKit

struct ScrollableText: UIViewRepresentable {

	var text: String

	func makeUIView(context: Context) -> ScrollableTextView {
		let scrollableText = ScrollableTextView()
		scrollableText.textView.text = text

		return scrollableText
	}

	func updateUIView(_ uiView: ScrollableTextView, context: Context) {
		uiView.textView.text = text
	}

	final class ScrollableTextView: UIScrollView {

		let textView = UITextView()

		override init(frame: CGRect) {
			super.init(frame: .zero)

			addSubview(textView)

			textView.isEditable = false
			textView.isScrollEnabled = false
			textView.snp.makeConstraints { make in
				make.edges.equalToSuperview()
			}
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
	}
}
