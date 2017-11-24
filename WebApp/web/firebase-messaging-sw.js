/**
 * Created by USER on 11/24/2017.
 */
importScripts('https://www.gstatic.com/firebasejs/3.9.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/3.9.0/firebase-messaging.js');

firebase.initializeApp({
    'messagingSenderId': '577101336097'
});


const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function(payload) {
    console.log('[firebase-messaging-sw.js] Received background message ', payload);
    // Customize notification here
    const notificationTitle = 'Background Message Title';
    // const notificationOptions = {
    //     body: 'Background Message body.',
    //     icon: '/firebase-logo.png'
    // };

    return self.registration.showNotification(notificationTitle);
});