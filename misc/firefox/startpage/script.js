const config = {
    "media": [
        "./img/1.jpg",
        "./img/2.jpg",
    ],
    "prompts": [
        "me@localhost:~$ ",
        "btw@arch:~$ ",
    ],
    "search": {
        "insert": ">q<",
        "url": "http://www.google.com/search?q=",
        "quotes": [
            "cat internet/* | grep >q<",
            "bat web/* | rg >q<",
            "awk '/>q</{print}'  ",
            "find -iname >q< /var/www",
            "fd >q< /var/www",
            "fd --hidden >q< #Deepweb search 🤡",
            "awk '/>q</{print}' ./internet/*",
        ],
    },
    "bookmarks": {
        "utils": {
            "webmail": "go use thunderbird you bloody fool",
            "classrooom": "https:classroom.google.com",
            "keep": "https:keep.google.com",
            "linkedin": "www.linkedin.com",
        },
        "inutils": { /* ha ha utils, inutils, inútil, eh? */
            "reddit": "https:reddit.com",
            "youtube": "https:youtube.com",
            "steam": "https:steampowered.com",
            "anilist": "https:anilist.co"
        },
        "dev": {
            "github": "https:github.com",
            "mankier": "https:mankier.com",
            "devdocs": "https:devdocs.io",
            "mdn": "https:developer.mozilla.org",
        },
        "practice": {
            "typingclub": "https:typingclub.com",
            "keybr": "https:keybr.com",
            "duolingo": "https:duolingo.com",
            "memrise": "app.memrise.com",
        },
        "comp-prog": {
            "hackerrank": "https:hackerrank.com",
            "codeforces": "https:codeforces.com",
            "cf-ladder": "https:earthshakira.github.io/a2oj-clientside/server/Ladders.html",
            "cses": "https:cses.fi/problemset/"
        },
    },
}

/* ------------------------------------------------------------------------- */

document.addEventListener("DOMContentLoaded", () => {
    document.body.classList.remove("preload");
})

/* ------------------------------------------------------------------------- */

// Pick random stuff, thanks to https://stackoverflow.com/questions/5915096/
const termp = config.prompts[Math.floor(Math.random() * config.prompts.length)];
const media = config.media[Math.floor(Math.random() * config.media.length)];
const quote = config.search.quotes[Math.floor(Math.random() * config.search.quotes.length)];

// Set media source
document.getElementById("media").setAttribute("src", media);

// Fill prompt text
Array.from(document.getElementsByClassName("prompt")).forEach(node => {
    node.appendChild(document.createTextNode(termp));
});

// Set up bookmarks using categories and name:link pairs
const linksNode = document.getElementById("links");

Object.entries(config.bookmarks).forEach(([group, sites]) => {
    let titleNode = document.createElement("li");
    titleNode.setAttribute("tabindex", "-1");
    titleNode.appendChild(document.createTextNode(group));

    let listNode = document.createElement("ul");
    listNode.appendChild(titleNode);

    Object.entries(sites).forEach(([link, destination]) => {
        let text = document.createTextNode(link);
        let anchor = document.createElement("a");
        let listItem = document.createElement("li");
        anchor.setAttribute("href", destination);
        anchor.appendChild(text);
        listItem.appendChild(anchor);
        listNode.appendChild(listItem);
    })

    linksNode.appendChild(listNode);
});

/* ------------------------------------------------------------------------- */

// Handle theming
function setTheme(theme) {
    if (!theme)
        theme = "system"

    localStorage.setItem("theme", theme);

    if (theme == "system" && window.matchMedia)
        theme = (window.matchMedia('(prefers-color-scheme: dark)').matches)
            ? "dark" : "light";

    document.body.classList.remove("dark-theme", "light-theme");

    if (theme == "light")
        document.body.classList.toggle("light-theme");
    else if (theme == "dark")
        document.body.classList.toggle("dark-theme");
}

setTheme(localStorage.getItem("theme"));

document.getElementById("light").onclick = () => { setTheme("light") }
document.getElementById("dark").onclick = () => { setTheme("dark") }
document.getElementById("system").onclick = () => { setTheme("system") }

window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
    if (curTheme == "system")
        setTheme("system")
});

/* ------------------------------------------------------------------------- */

// Set up search input block
let auxNode = document.createElement("span");
auxNode.setAttribute("id", "search");
auxNode.setAttribute("contenteditable", "true");

const quoteNode = document.getElementById("search-quote");
quoteNode.innerHTML = quote.replace(config.search.insert, auxNode.outerHTML);

const searchNode = document.getElementById("search");
searchNode.setAttribute("tabindex", 1);
searchNode.focus();
searchNode.addEventListener("keypress", (e) => {
    if (e.key == "Enter") {
        window.location.href = config.search.url + searchNode.textContent;
        e.preventDefault(); // Prevent line break
    }
});

setTimeout(function () {
    searchNode.focus();
}, 2000);
