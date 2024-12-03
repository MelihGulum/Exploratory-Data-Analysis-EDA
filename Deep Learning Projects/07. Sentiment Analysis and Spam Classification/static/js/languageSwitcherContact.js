const langEl= document.querySelector('.langWrap');
const link= document.querySelectorAll('a');

const titleEl= document.querySelector('.title');
const greetingsEl= document.querySelector('.greetings');

const checkboxEl= document.querySelector('#checkbox');

const homeEl= document.querySelector('.home');
const aboutEl= document.querySelector('.about');
const contactEl= document.querySelector('.contact');
const projectEl= document.querySelector('.project');

const feedbackEl= document.querySelector('.feedback');

link.forEach(el => {
            el.addEventListener('click', () => {
                langEl.querySelector('.active').classList.remove('active');
                el.classList.add('active');

                const attr = el.getAttribute('language');

                titleEl.textContent = data[attr].title;
                greetingsEl.textContent = data[attr].greetings;

                checkboxEl.textContent = data[attr].checkbox;
                console.log(checkboxEl.textContent);

                homeEl.textContent = data[attr].home;
                aboutEl.textContent = data[attr].about;
                contactEl.textContent = data[attr].contact;
                projectEl.textContent = data[attr].project;

                feedbackEl.textContent = data[attr].feedback;
            });
});
var data = {
        "english":
        {
            "title":"GET IN TOUCH",
            "greetings":"Send us a message",

            "checkbox":"Yes, I would like to receive communications by call / email about Company's services.",

            "home":"Home",
            "about":"About",
            "contact":"Contact",
            "project":"Project",

            "feedback":"Your feedback is very important to us.",


        },
        "turkish":
        {
            "title":"İLETİŞİM",
            "greetings":"Mesajınızı gönderin",

            "checkbox":"Evet, şirket servisinin mail ve aramalarını almak isterim",

            "home":"Ana Sayfa",
            "about":"Hakkımızda",
            "contact":"İletışım",
            "project":"Proje",

            "feedback":"Mesajınız bizim için çok önemli",

        }
}