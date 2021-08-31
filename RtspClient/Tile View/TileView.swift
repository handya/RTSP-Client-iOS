//
//  TileView.swift
//  RtspClient
//
//  Created by Andrew Farquharson on 1/09/21.
//  Copyright © 2021 Andres Rojas. All rights reserved.
//

import UIKit

class TitleView: UIView {

    init() {
        super.init(frame: .zero)
        backgroundColor = .black

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
           // stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var stackView: UIStackView = {
        let result: UIStackView = .init()
        result.axis = .vertical
        result.spacing = 22
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()

    func start() {
        stackView.addArrangedSubview(firstRow)
    }

    private lazy var firstRow: UIStackView = {
        let result: UIStackView = .init(arrangedSubviews: [
            PlayerView(streamUrl: "rtsp://10.1.1.1:7447/mAZtAJD9I7QiQqDz"),
            PlayerView(streamUrl: "rtsp://10.1.1.1:7447/k8hfFi88FQL9LCbx")
        ])
        result.distribution = .fillEqually
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()

    private lazy var secondRow: UIStackView = {
        let result: UIStackView = .init(arrangedSubviews: [
            PlayerView(streamUrl: "rtsp://10.1.1.1:7447/mAZtAJD9I7QiQqDz"),
            PlayerView(streamUrl: "rtsp://10.1.1.1:7447/k8hfFi88FQL9LCbx")
        ])
        result.distribution = .fillEqually
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
}


class PlayerView: UIView {
    private let video: RTSPPlayer?

    init(streamUrl: String ) {
        video = RTSPPlayer(video: streamUrl, usesTcp: false)
        super.init(frame: .zero)

        video?.outputWidth = 640
        video?.outputHeight = 360
        video?.seekTime(0.0)

        addSubview(imageView)
        addSubview(activityIndicatorView)

        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalTo: widthAnchor, multiplier: 9 / 16)
        ])

        let timer = Timer.scheduledTimer(timeInterval: 1.0/30, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        timer.fire()

        activityIndicatorView.startAnimating()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let activityIndicatorView: UIActivityIndicatorView = {
        let result: UIActivityIndicatorView = .init(activityIndicatorStyle: .whiteLarge)
        result.color = .systemBlue
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()

    private let imageView: UIImageView = {
        let result: UIImageView = .init()
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
}

private extension PlayerView {
    @objc func update(timer: Timer) {
        if(!video!.stepFrame()){
            timer.invalidate()
            video!.closeAudio()
        }
        imageView.image = video!.currentImage

        if activityIndicatorView.isAnimating {
            activityIndicatorView.stopAnimating()
        }
    }
}
/*
 var video: RTSPPlayer!

 override func viewDidLoad() {
 super.viewDidLoad()
 // Do any additional setup after loading the view, typically from a nib.

 video = RTSPPlayer(video: "rtsp://10.1.1.1:7447/JPOZkA3ym9XnokPm", usesTcp: false)
 video.outputWidth = 1024
 video.outputHeight = 576
 video.seekTime(0.0)

 let timer = Timer.scheduledTimer(timeInterval: 1.0/30, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
 timer.fire()
 }

 @objc func update(timer: Timer) {
 if(!video.stepFrame()){
 timer.invalidate()
 video.closeAudio()
 }
 // imageView.image = video.currentImage
 }

 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 }


 }
 */
