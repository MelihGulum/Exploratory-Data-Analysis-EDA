const langEl= document.querySelector('.langWrap');
const link= document.querySelectorAll('a');

const sentiment_titleEl= document.querySelector('.sentiment_title');
const sentiment_descriptionEl= document.querySelector('.sentiment_description');
const spam_titleEl= document.querySelector('.spam_title');
const spam_descriptionEl= document.querySelector('.spam_description');
const dataset_titleEl= document.querySelector('.dataset_title');
const dataset_descriptionEl= document.querySelector('.dataset_description');

const homeEl= document.querySelector('.home');
const aboutEl= document.querySelector('.about');
const contactEl= document.querySelector('.contact');
const projectEl= document.querySelector('.project');

const btnEl= document.querySelector('.btn');
const btn2El= document.querySelector('.btn2');
const btn3El= document.querySelector('.btn3');


link.forEach(el => {
            el.addEventListener('click', () => {
                langEl.querySelector('.active').classList.remove('active');
                el.classList.add('active');

                const attr = el.getAttribute('language');

                sentiment_titleEl.textContent = data[attr].sentiment_title;
                sentiment_descriptionEl.textContent = data[attr].sentiment_description;

                spam_titleEl.textContent = data[attr].spam_title;
                spam_descriptionEl.textContent = data[attr].spam_description;

                dataset_titleEl.textContent = data[attr].dataset_title;
                dataset_descriptionEl.textContent = data[attr].dataset_description;

                homeEl.textContent = data[attr].home;
                aboutEl.textContent = data[attr].about;
                contactEl.textContent = data[attr].contact;
                projectEl.textContent = data[attr].project;

                btnEl.textContent = data[attr].btn;
                btn2El.textContent = data[attr].btn2;
                btn3El.textContent = data[attr].btn3;
            });
});

var data = {
        "english":
        {
            "sentiment_title": "Sentiment Anlaysis",
            "sentiment_description":
                    "Could not you decide the sentence is whether good or bad? We know it is difficult to decides sometimes.Let us help you with our Deep Learning model which has %79 Accuracy.",

            "spam_title":"Spam Classification",
            "spam_description":"Did you ever take ridiculous message from the person who you do not know? If your answer 'yes', than this message probably is spam. Do you want to know which one is spam?",

            "dataset_title":"About Datasets",
            "dataset_description":"We use two different dataset in these projects. Sentiment dataset consist of 1.6 million data. On the other hand the other dataset, spam dataset, has 5572 data.",

            "home":"Home",
            "about":"About",
            "contact":"Contact",
            "project":"Project",

            "btn":"Learn",
            "btn2":"Learn",
            "btn3":"Sentiment",
        },
        "turkish":
        {
            "sentiment_title": "Duygu Analizi",
            "sentiment_description":"Cümlelerin olumlu ya da olumsuz olduğuna karar veremediniz mi? Bu kararı vermenin bazen zor olduğunu anlıyoruz. %79 başarım oranına sahip Derin Öğrenme modelimiz ile size yardım edelim.",

            "spam_title":"Spam Sınıflandırma",
            "spam_description":"Tanımadığınız kişilerden saçma mesajlardan aldığınız oldu mu? Cevabınız eğer 'evet' ise bu mesaj büyük ihtimalle spam. Hangi mesajın spam olup   olmadığını öğrenmek ister misiniz?",

            "dataset_title":"Veri Setleri",
            "dataset_description":"Bu projede iki farklı veri seti kullandık. Duygu veri seti 1.6 milyon veriden oluşmaktadır. Diğer taraftan spam veri setimiz ise 5571 veriden meydana gelmektedir.",

            "home":"Ana Sayfa",
            "about":"Hakkımızda",
            "contact":"İletışım",
            "project":"Proje",

            "btn":"Öğren",
            "btn2":"Öğren",
            "btn3":"Duygu",
        }

}

/*                 window.alert()     */


function sentiment_alert() {
  alert("We need time to solve it.");
}

function dataset_alert() {
  alert("Please wait. It's trying to randomly display data.");
}
