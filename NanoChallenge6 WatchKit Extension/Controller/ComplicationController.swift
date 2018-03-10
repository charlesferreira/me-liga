//
//  ComplicationController.swift
//  NanoChallenge6 WatchKit Extension
//
//  Created by Charles Ferreira on 06/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        guard let happiness = DataModel.shared.averageHappiness,
            let template = template(for: complication.family, happiness: Float(happiness)) else { return }
        
        let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
        handler(entry)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        
        let sampleTemplate = template(for: complication.family)
        handler(sampleTemplate)
    }
    
    // MARK: - Meus templates
    
    private func circularSmallTemplate(happiness: Float) -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateCircularSmallRingImage()
        template.ringStyle = .closed
        template.fillFraction = happiness
        template.imageProvider = CLKImageProvider(onePieceImage: #imageLiteral(resourceName: "Complication/Circular"))
        template.tintColor = Happiness.tintColor(for: happiness)
        return template
    }
    
    private func modularSmallTemplate(happiness: Float) -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateModularSmallRingImage()
        template.ringStyle = .closed
        template.fillFraction = happiness
        template.imageProvider = CLKImageProvider(onePieceImage: #imageLiteral(resourceName: "Complication/Modular"))
        template.tintColor = Happiness.tintColor(for: happiness)
        return template
    }
    
    private func template(for family: CLKComplicationFamily, happiness: Float = 0.75) -> CLKComplicationTemplate? {
        switch family {
        case .circularSmall:
            return circularSmallTemplate(happiness: happiness)
        case .modularSmall:
            return modularSmallTemplate(happiness: happiness)
        default:
            return nil
        }
    }
}
