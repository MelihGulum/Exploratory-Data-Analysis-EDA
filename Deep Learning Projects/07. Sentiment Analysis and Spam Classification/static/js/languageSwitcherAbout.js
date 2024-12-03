const langEl= document.querySelector('.langWrap');
const link= document.querySelectorAll('a');

const homeEl= document.querySelector('.home');
const aboutEl= document.querySelector('.about');
const contactEl= document.querySelector('.contact');
const projectEl= document.querySelector('.project');

const titleEl= document.querySelector('.title');
const title2El= document.querySelector('.title2');

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
                title2El.textContent = data[attr].title2;

            });
});

var data = {
        "english":
        {
            "home":"Home",
            "about":"About",
            "contact":"Contact",
            "project":"Project",

            "title":"JUNIOR DATA SCIENTIST & WEB DEVELOPER",
            "title2":"JUNIOR DATA SCIENTIST & WEB DEVELOPER",
        },
        "turkish":
        {
            "home":"Ana Sayfa",
            "about":"Hakkımızda",
            "contact":"İletışım",
            "project":"Proje",

            "title":"Verı Bilimci ve Web Programlayıcısı",
            "title2":"Verı Bilimci ve Web Programlayıcısı",
        }
}