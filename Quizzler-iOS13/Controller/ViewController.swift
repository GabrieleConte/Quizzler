//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var quizBrain=QuizBrain()
    
    @IBOutlet weak var domanda: UILabel!
    @IBOutlet weak var barra: UIProgressView!
    @IBOutlet weak var vero: UIButton!
    @IBOutlet weak var falso: UIButton!
    @IBOutlet weak var score: UILabel!
    
    var m: Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizBrain.punteggio=0
        updateUI()
    }

    @IBAction func bottonePremuto(_ sender: UIButton) {
        let risposta = sender.currentTitle!
        
        let l=quizBrain.checkAnswer(risposta)
        if l{
            sender.backgroundColor=UIColor.green
        }else{
            sender.backgroundColor=UIColor.red
        }
        if risposta=="Retry your test"{
            schermataIniziale()
        }else if risposta=="Get out"{
            exit(0)
        }
        m=quizBrain.punteggio
        quizBrain.nextQuestion()
        if quizBrain.numDomanda==0&&quizBrain.flag==true{
            quizBrain.punteggio=m
            schermataFinale()
            quizBrain.reset()
        }else{
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)}
        
    }
    
    @objc func updateUI(){
        domanda.text = quizBrain.checkDomanda()
        score.text="Score: \(quizBrain.getScore())"
        vero.backgroundColor=UIColor.clear
        falso.backgroundColor=UIColor.clear
        barra.progress=quizBrain.updateBar()
    }
    func schermataFinale(){
        falso.setTitle("Get out", for: UIControl.State.normal)
        vero.setTitle("Retry your test", for: UIControl.State.normal)
        falso.backgroundColor=UIColor.clear
        vero.backgroundColor=UIColor.clear
        score.text="Well Done!"
        score.textAlignment=NSTextAlignment.center
        score.font=UIFont.systemFont(ofSize: 30)
        domanda.text="Il tuo Score: \n \(quizBrain.punteggio)"
        domanda.textAlignment=NSTextAlignment.center
        domanda.font=UIFont.systemFont(ofSize: 40)
        
    }
    
    func schermataIniziale(){
        quizBrain.ricomincia=true
        quizBrain.numDomanda=0
        vero.setTitle("True", for: UIControl.State.normal)
        falso.setTitle("False", for: UIControl.State.normal)
        score.text="Score"
        score.textAlignment=NSTextAlignment.left
        score.font=UIFont.systemFont(ofSize: 17)
        domanda.font=UIFont.systemFont(ofSize: 30)
        domanda.textAlignment=NSTextAlignment.left
        domanda.text="Domanda"
    }
    
}

