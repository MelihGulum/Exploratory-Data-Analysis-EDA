const langEl= document.querySelector('.langWrap');
const link= document.querySelectorAll('a');

const homeEl= document.querySelector('.home');
const aboutEl= document.querySelector('.about');
const contactEl= document.querySelector('.contact');
const projectEl= document.querySelector('.project');


const titleEl= document.querySelector('.title');
const sentiment_titleEl= document.querySelector('.sentiment_title');
const spam_titleEl= document.querySelector('.spam_title');

const info1El= document.querySelector('.info1');
const info2El= document.querySelector('.info2');
const sentiment_modelEl= document.querySelector('.sentiment_model');

const info3El= document.querySelector('.info3');
const spam_modelEl= document.querySelector('.spam_model');

link.forEach(el => {
            el.addEventListener('click', () => {
                langEl.querySelector('.active').classList.remove('active');
                el.classList.add('active');

                const attr = el.getAttribute('language');

                homeEl.textContent = data[attr].home;
                aboutEl.textContent = data[attr].about;
                contactEl.textContent = data[attr].contact;
                projectEl.textContent = data[attr].project;

                titleEl.textContent = data[attr].title;
                sentiment_titleEl.textContent = data[attr].sentiment_title;
                spam_titleEl.textContent = data[attr].spam_title;

                info1El.textContent = data[attr].info1;
                info2El.textContent = data[attr].info2;
                sentiment_modelEl.textContent = data[attr].sentiment_model;

                info3El.textContent = data[attr].info3;
                spam_modelEl.textContent = data[attr].spam_model;

            });
});
var data = {
        "english":
        {
            "home":"Home",
            "about":"About",
            "contact":"Contact",
            "project":"PROJECT",

            "title":"Project",
            "sentiment_title":"SENTIMENT ANALYSIS",
            "spam_title":"SPAM CLASSIFICATION",

            "info1":"The first thing to do is to clean the data. Such as '@' sign, uppercase lowercase conversion and vice versa ...",
            "info2":"Afterwards we generate Word2Vec from our training set. Then we transform W2V to embedding layer",
            "sentiment_model":"Model was based on LSTM which is one of the architecture in Deep Learning.",

            "info3":"In Spam Classification we extract the features with the help of CountVectorizer. Then we fit the data",
            "spam_model":"This classifer's data set is smaller than the other. So model was built in Naive Bayes architecture, which belongs statistical Machine Learning",

        },

        "turkish":
        {

            "home":"Ana Sayfa",
            "about":"Hakkımızda",
            "contact":"İletışım",
            "project":"Proje",

            "title":"PROJE",
            "sentiment_title":"DUYGU ANALIZI",
            "spam_title":"SPAM SINIFLANDIRMA",

             "info1":"Yapılacak ilk şey verileri temizlemektir. '@' işareti, büyük harf küçük harf dönüşümü ve tersi gibi ... ",
             "info2":"Daha sonra eğitim setimizden Word2Vec üretiyoruz. Sonra W2V'yi gömme katmanına dönüştürüyoruz",
             "sentiment_model": "Derin Öğrenmenin mimarilerinden biri olan LSTM tabanlı modeldir.",

             "info3":"Spam Sınıflandırmasında, özniteliklerini CountVectorizer yardımıyla çıkarıyoruz. Sonra verileri fit'liyoruz.",
             "spam_model": "Bu sınıflandırıcının veri seti diğerinden daha küçüktür. Böylece model, istatistiksel Makine Öğrenimine ait olan Naive Bayes mimarisinde oluşturulmuştur.",
         }
}