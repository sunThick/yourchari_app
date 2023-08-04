
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class TermsOfUserPage extends StatelessWidget {
  const TermsOfUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('利用規約'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'この利用規約（以下、「本規約」といいます。）は、your chari（以下、「当社」といいます。）がこのウェブサイト上で提供するサービス（以下、「本サービス」といいます。）の利用条件を定めるものです。登録ユーザーの皆さま（以下、「ユーザー」といいます。）には、本規約に従って、本サービスをご利用いただきます。',
            ),
          ),
          for (final value in articles.withIndex)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${value.item1 + 1} :${value.item2.title}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                for (final term in value.item2.terms)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          '・${term.termTitle}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final list in term.list)
                              Text(
                                '・$list',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w100),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                const Divider(),
              ],
            ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '以上',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class Article {
  Article({required this.title, required this.terms});
  String title;
  List<Term> terms;
}

class Term {
  Term({required this.termTitle, required this.list});
  String termTitle;
  List list;
}

extension IterableExtension<T> on List<T> {
  List<Tuple2<int, T>> get withIndex {
    final list = <Tuple2<int, T>>[];
    asMap().forEach((index, element) {
      list.add(Tuple2(index, element));
    });
    return list;
  }
}

final articles = [
  Article(title: '適用', terms: [
    Term(termTitle: '本規約は，ユーザーと当社との間の本サービスの利用に関わる一切の関係に適用されるものとします。', list: []),
    Term(
        termTitle:
            '当社は本サービスに関し，本規約のほか，ご利用にあたってのルール等，各種の定め（以下，「個別規定」といいます。）をすることがあります。これら個別規定はその名称のいかんに関わらず，本規約の一部を構成するものとします。',
        list: []),
    Term(
        termTitle:
            '本規約の規定が前条]の個別規定の規定と矛盾する場合には，個別規定において特段の定めなき限り，個別規定の規定が優先されるものとします。',
        list: []),
  ]),
  Article(title: '利用登録', terms: [
    Term(
        termTitle:
            '本サービスにおいては，登録希望者が本規約に同意の上，当社の定める方法によって利用登録を申請し，当社がこの承認を登録希望者に通知することによって，利用登録が完了するものとします。',
        list: []),
    Term(
        termTitle:
            '当社は，利用登録の申請者に以下の事由があると判断した場合，利用登録の申請を承認しないことがあり，その理由については一切の開示義務を負わないものとします。',
        list: [
          '利用登録の申請に際して虚偽の事項を届け出た場合',
          '本規約に違反したことがある者からの申請である場合',
          'その他，当社が利用登録を相当でないと判断した場合'
        ]),
  ]),
  Article(title: 'ユーザーIDおよびパスワードの管理', terms: [
    Term(
        termTitle: 'ユーザーは，自己の責任において，本サービスのユーザーIDおよびパスワードを適切に管理するものとします。',
        list: []),
    Term(
        termTitle:
            'ユーザーは，いかなる場合にも，ユーザーIDおよびパスワードを第三者に譲渡または貸与し，もしくは第三者と共用することはできません。当社は，ユーザーIDとパスワードの組み合わせが登録情報と一致してログインされた場合には，そのユーザーIDを登録しているユーザー自身による利用とみなします。',
        list: []),
    Term(
        termTitle:
            'ユーザーID及びパスワードが第三者によって使用されたことによって生じた損害は，当社に故意又は重大な過失がある場合を除き，当社は一切の責任を負わないものとします。',
        list: [])
  ]),
  Article(title: '利用料金および支払方法', terms: [
    Term(
        termTitle:
            'ユーザーは，本サービスの有料部分の対価として，当社が別途定め，本ウェブサイトに表示する利用料金を，当社が指定する方法により支払うものとします。',
        list: []),
  ]),
  Article(title: '禁止事項', terms: [
    Term(termTitle: '法令または公序良俗に違反する行為', list: []),
    Term(termTitle: '犯罪行為に関連する行為', list: []),
    Term(
        termTitle: '当社，本サービスの他のユーザー，または第三者のサーバーまたはネットワークの機能を破壊したり，妨害したりする行為',
        list: []),
    Term(termTitle: '他のユーザーに関する個人情報等を収集または蓄積する行為', list: []),
    Term(termTitle: '不正アクセスをし，またはこれを試みる行為', list: []),
    Term(termTitle: '他のユーザーに成りすます行為', list: []),
    Term(termTitle: '当社のサービスに関連して，反社会的勢力に対して直接または間接に利益を供与する行為', list: []),
    Term(
        termTitle:
            '当社，本サービスの他のユーザーまたは第三者の知的財産権，肖像権，プライバシー，名誉その他の権利または利益を侵害する行為',
        list: []),
    Term(termTitle: '以下の表現を含み，または含むと当社が判断する内容を本サービス上に投稿し，または送信する行為', list: [
      '過度に暴力的な表現',
      '露骨な性的表現',
      '人種，国籍，信条，性別，社会的身分，門地等による差別につながる表現',
      '自殺，自傷行為，薬物乱用を誘引または助長する表現',
      'その他反社会的な内容を含み他人に不快感を与える表現',
      '以下を目的とし，または目的とすると当社が判断する行為',
      '営業，宣伝，広告，勧誘，その他営利を目的とする行為（当社の認めたものを除きます。）',
      '性行為やわいせつな行為を目的とする行為',
      '面識のない異性との出会いや交際を目的とする行為',
      '他のユーザーに対する嫌がらせや誹謗中傷を目的とする行為',
      '当社，本サービスの他のユーザー，または第三者に不利益，損害または不快感を与えることを目的とする行為',
      'その他本サービスが予定している利用目的と異なる目的で本サービスを利用する行為',
    ]),
    Term(termTitle: '宗教活動または宗教団体への勧誘行為', list: []),
    Term(termTitle: 'その他，当社が不適切と判断する行為', list: []),
  ]),
  Article(title: '本サービスの提供の停止等', terms: [
    Term(
        termTitle:
            '当社は，以下のいずれかの事由があると判断した場合，ユーザーに事前に通知することなく本サービスの全部または一部の提供を停止または中断することができるものとします。',
        list: [
          '本サービスにかかるコンピュータシステムの保守点検または更新を行う場合'
              '地震，落雷，火災，停電または天災などの不可抗力により，本サービスの提供が困難となった場合'
              'コンピュータまたは通信回線等が事故により停止した場合'
              'その他，当社が本サービスの提供が困難と判断した場合'
        ]),
    Term(
        termTitle:
            '当社は，本サービスの提供の停止または中断により，ユーザーまたは第三者が被ったいかなる不利益または損害についても，一切の責任を負わないものとします。',
        list: []),
  ]),
  Article(title: '著作権', terms: [
    Term(
        termTitle:
            'ユーザーは，自ら著作権等の必要な知的財産権を有するか，または必要な権利者の許諾を得た文章，画像や映像等の情報に関してのみ，本サービスを利用し，投稿ないしアップロードすることができるものとします。',
        list: []),
    Term(
        termTitle:
            'ユーザーが本サービスを利用して投稿ないしアップロードした文章，画像，映像等の著作権については，当該ユーザーその他既存の権利者に留保されるものとします。ただし，当社は，本サービスを利用して投稿ないしアップロードされた文章，画像，映像等について，本サービスの改良，品質の向上，または不備の是正等ならびに本サービスの周知宣伝等に必要な範囲で利用できるものとし，ユーザーは，この利用に関して，著作者人格権を行使しないものとします。',
        list: []),
    Term(
        termTitle:
            '前項本文の定めるものを除き，本サービスおよび本サービスに関連する一切の情報についての著作権およびその他の知的財産権はすべて当社または当社にその利用を許諾した権利者に帰属し，ユーザーは無断で複製，譲渡，貸与，翻訳，改変，転載，公衆送信（送信可能化を含みます。），伝送，配布，出版，営業使用等をしてはならないものとします。',
        list: []),
  ]),
  Article(title: '利用制限および登録抹消', terms: [
    Term(
        termTitle:
            '当社は，ユーザーが以下のいずれかに該当する場合には，事前の通知なく，投稿データを削除し，ユーザーに対して本サービスの全部もしくは一部の利用を制限しまたはユーザーとしての登録を抹消することができるものとします。',
        list: [
          '本規約のいずれかの条項に違反した場合',
          '登録事項に虚偽の事実があることが判明した場合',
          '決済手段として当該ユーザーが届け出たクレジットカードが利用停止となった場合',
          '料金等の支払債務の不履行があった場合',
          '当社からの連絡に対し，一定期間返答がない場合',
          '本サービスについて，最終の利用から一定期間利用がない場合',
          'その他，当社が本サービスの利用を適当でないと判断した場合',
        ]),
    Term(
        termTitle:
            '前項各号のいずれかに該当した場合，ユーザーは，当然に当社に対する一切の債務について期限の利益を失い，その時点において負担する一切の債務を直ちに一括して弁済しなければなりません。',
        list: []),
    Term(
        termTitle: '当社は，本条に基づき当社が行った行為によりユーザーに生じた損害について，一切の責任を負いません。',
        list: []),
  ]),
  Article(title: '退会', terms: [
    Term(termTitle: 'ユーザーは，当社の定める退会手続により，本サービスから退会できるものとします。', list: []),
  ]),
  Article(title: '保証の否認および免責事項', terms: [
    Term(
        termTitle:
            '当社は，本サービスに事実上または法律上の瑕疵（安全性，信頼性，正確性，完全性，有効性，特定の目的への適合性，セキュリティなどに関する欠陥，エラーやバグ，権利侵害などを含みます。）がないことを明示的にも黙示的にも保証しておりません。',
        list: []),
    Term(
        termTitle:
            '当社は，本サービスに起因してユーザーに生じたあらゆる損害について、当社の故意又は重過失による場合を除き、一切の責任を負いません。ただし，本サービスに関する当社とユーザーとの間の契約（本規約を含みます。）が消費者契約法に定める消費者契約となる場合，この免責規定は適用されません。',
        list: []),
    Term(
        termTitle:
            '前項ただし書に定める場合であっても，当社は，当社の過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害のうち特別な事情から生じた損害（当社またはユーザーが損害発生につき予見し，または予見し得た場合を含みます。）について一切の責任を負いません。また，当社の過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害の賠償は，ユーザーから当該損害が発生した月に受領した利用料の額を上限とします。',
        list: []),
    Term(
        termTitle:
            '当社は，本サービスに関して，ユーザーと他のユーザーまたは第三者との間において生じた取引，連絡または紛争等について一切責任を負いません。',
        list: [])
  ]),
  Article(title: 'サービス内容の変更等', terms: [
    Term(
        termTitle:
            '当社は，ユーザーへの事前の告知をもって、本サービスの内容を変更、追加または廃止することがあり、ユーザーはこれを承諾するものとします。',
        list: []),
  ]),
  Article(title: '利用規約の変更', terms: [
    Term(termTitle: '当社は以下の場合には、ユーザーの個別の同意を要せず、本規約を変更することができるものとします。', list: [
      '本規約の変更がユーザーの一般の利益に適合するとき。',
      '本規約の変更が本サービス利用契約の目的に反せず、かつ、変更の必要性、変更後の内容の相当性その他の変更に係る事情に照らして合理的なものであるとき。'
    ]),
    Term(
        termTitle:
            '当社はユーザーに対し、前項による本規約の変更にあたり、事前に、本規約を変更する旨及び変更後の本規約の内容並びにその効力発生時期を通知します。',
        list: []),
  ]),
  Article(title: '個人情報の取扱い', terms: [
    Term(
        termTitle:
            '当社は，本サービスの利用によって取得する個人情報については，当社「プライバシーポリシー」に従い適切に取り扱うものとします。',
        list: []),
  ]),
  Article(title: '通知または連絡', terms: [
    Term(termTitle: 'ユーザーと当社との間の通知または連絡は，当社の定める方法によって行うものとします。当社は', list: []),
  ]),
  Article(title: '権利義務の譲渡の禁止', terms: [
    Term(
        termTitle:
            'ユーザーは，当社の書面による事前の承諾なく，利用契約上の地位または本規約に基づく権利もしくは義務を第三者に譲渡し，または担保に供することはできません。',
        list: []),
  ]),
  Article(title: '準拠法・裁判管轄', terms: [
    Term(termTitle: '本規約の解釈にあたっては，日本法を準拠法とします。', list: []),
    Term(
        termTitle: '本サービスに関して紛争が生じた場合には，当社の本店所在地を管轄する裁判所を専属的合意管轄とします。',
        list: []),
  ]),
];
