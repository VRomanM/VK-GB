//
//  NewsViewController.swift
//  VK GB
//
//  Created by Роман Вертячих on 24.05.2022.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let vkNews = [News(title: "Мандат платежом красен", text: """
                                С бывшего мэра Иркутска требуют почти 2 млн рублей за выборы
                                Избирательная комиссия Иркутска подготовила судебный иск к бывшему мэру города единороссу Дмитрию Бердникову с требованием возместить 1,75 млн руб. за проведение повторных выборов в гордуму. В 2019 году господин Бердников баллотировался в депутаты с целью пролонгировать свои полномочия (тогда градоначальник избирался из числа парламентариев), но в итоге от мандата отказался. Сейчас чиновник работает первым заместителем председателя правительства Якутии.
                                """
                       , like: 10, photo: [Photo(id: "news1", description: "Депутат", like: 0)]),
                  News(title: "ВТБ предложил Минфину новые стимулы для развития в России рынка бриллиантов", text: """
                                              Меры по развитию внутренней альтернативы валютным инвестиционным активам и поддержке алмазной отрасли могли быть гораздо более масштабными, чем обнуление НДС для физлиц при сделках с драгоценными камнями, выяснили «Ведомости».
                                              """
                                     , like: 0, photo: [Photo(id: "news2", description: "Алмаз в руке", like: 0)])]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vkNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else {
            preconditionFailure("Error")
        }
        
        cell.title.text = vkNews[indexPath.row].title
        cell.textNews.text = vkNews[indexPath.row].text
        cell.imageNews.image = UIImage(named: vkNews[indexPath.row].photo[0].id)
        cell.title.text = vkNews[indexPath.row].title
        cell.likeCount.text = String(vkNews[indexPath.row].like + vkNews[indexPath.row].myLike)
        if vkNews[indexPath.row].myLike == 1 {
            cell.likeControl.likeImage.image = UIImage(systemName: "suit.heart")
        }
        
        return cell
    }
    
}
