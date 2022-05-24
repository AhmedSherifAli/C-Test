const sign_in_btn = document.querySelector("#sign-in-btn");
const sign_up_btn = document.querySelector("#sign-up-btn");
const container = document.querySelector(".container");

sign_up_btn.addEventListener('click', () => {
    container.classList.add("sign-up-mode");
});

sign_in_btn.addEventListener('click', () => {
    container.classList.remove("sign-up-mode");
});

function myfunction() {
    var show1 = document.getElementById('PasswordSignUp')
    var show2 = document.getElementById('PasswordSignUpRepeat')
    if (show1.type == 'password' || show2.type == 'password') {
        show1.type = 'text';
        show2.type = 'text';
    }
    else {
        show1.type = 'password';
        show2.type = 'password';
    }
}