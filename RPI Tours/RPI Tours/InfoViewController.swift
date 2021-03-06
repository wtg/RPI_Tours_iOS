//
//  InfoViewController.swift
//  RPI Tours
//
//  Created by Jacob Speicher on 8/1/16.
//  Copyright © 2016 RPI Web Tech. All rights reserved.
//

import UIKit
import ReachabilitySwift
import CoreLocation
import ImageSlideshow
import AlamofireImage

class InfoViewController: UITableViewController {

    // MARK: IBOutlets
    @IBOutlet var landmarkDescriptionLabel: UILabel!
    @IBOutlet var descriptionCell: UITableViewCell!

    // MARK: Global Variables
    var landmarkName: String = ""
    var landmarkDesc: String = ""
    var landmarkInformation: [Landmark] = []

    @IBOutlet weak var slideShow: ImageSlideshow!
    var cameFromMap: Bool = false

    // MARK: Segues
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "imageSlider" {
//        }
//    }

    // MARK: System Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.landmarkName
        let chosenLandmark = searchForLandmark()

        self.landmarkDescriptionLabel.text = chosenLandmark.desc

        var images: [InputSource] = []


        for imageURL in chosenLandmark.urls {
            images.append(AlamofireSource(urlString: imageURL)!)
        }

        slideShow.setImageInputs(images)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Helper Functions
    func searchForLandmark() -> Landmark {

        for landmark in self.landmarkInformation {
            if landmark.name == self.landmarkName && !landmark.desc.isEmpty {
                return landmark
            }
        }

        let blankLandmark = Landmark(name: "Unknown Landmark",
                                     desc: "I'm sorry, there is no information yet for this landmark.",
                                     lat: 0.0,
                                     long: 0.0, urls:[])

        return blankLandmark
    }

    // MARK: TableView Functions

    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {
            return CGFloat(Constants.CellHeights.InfoHeights.tall)
        }

        return CGFloat(Constants.CellHeights.InfoHeights.short)
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {
            return CGFloat(Constants.CellHeights.InfoHeights.tall)
        }

        return CGFloat(Constants.CellHeights.InfoHeights.short)
    }
}
