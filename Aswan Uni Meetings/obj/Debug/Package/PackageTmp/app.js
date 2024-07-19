                // MenuToggle

//let toggle = document.querySelector('.toggle');
//let navigation = document.querySelector('.navigation');
//let main = document.querySelector('.main');

//toggle.onclick = function () {
//    navigation.classList.toggle('active');
//    main.classList.toggle('active');
//}


// Add hovered class in selected list item

let list = document.querySelectorAll('.navigation li');

let list_en = document.querySelectorAll('.navigation-en li');

function activelink() {
    list.forEach((item) =>
        item.classList.remove('hovered'));

    list_en.forEach((item) =>
        item.classList.remove('hovered'));

    this.classList.add('hovered');

}

// Generate hovered class by mouse click 

list.forEach((item) => item.addEventListener('click', activelink));

list_en.forEach((item) => item.addEventListener('click', activelink));

// Generate hovered class by mouse hover

//list.forEach((item) => item.addEventListener('mouseover', activelink));

            // Upload File Button

const input = document.getElementById("ContentPlaceHolder1_upload");
const text = document.getElementById("text");
const btn = document.getElementById("upload-btn");

input.addEventListener("change", () => {
    const path = input.value.split('\\')
    const filename = path[path.length - 1]

    text.innerText = filename ? filename : "Choose File"

    text.innerText = filename ? filename : "أختر الملف"

    if (filename)
        btn.classList.add("chosen")
    else
        btn.classList.remove("chosen")
})

