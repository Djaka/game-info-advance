//
//  ProfileModelMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 15/07/23.
//

import Foundation

@testable import GameInfoAdvance

var profileModelMock = ProfileModel(
    author: "Djaka Permana",
    email: "djakapermana95@gmail.com",
    currentJob: " iOS Developer",
    description: "Aplikasi ini merupakan aplikasi catalog game yang di rancang khusus untuk keperluan submission capstone project pada modul Belajar Menjadi iOS developer expert. Project ini merupakan perkembangan dari versi sebelumnya pada submission akhir di module belajar fundamental iOS. Versi project ini sudah menggunakan design clean architecture, manual dependency injection, serta reactive programming menggunakan Rx Swift. Aplikasi ini terdapat beberapa halaman diantaranya adalah: <br><br>1. Halaman home (games) yg berfungsi untuk menampilkan list atau catalog game yang mana pada halaman tersebut terdapat feature pencarian dan pagination<br>2. Halaman detail game berfungsi menampilkan detail dari game yg telah dipilih dari list game<br>3. Halaman List Favorites merupakan halaman yang menampilkan list favorite game yang sudah di wishlist dan terdapat feature pencarian pada halaman tersebut<br>4. Halaman About, merupakan halaman yang menjelaskan tentang aplikasi serta profile pembuat aplikasi<br>5. Halaman edit profile, berfungsi untuk mengupdate nama, email, dan juga pekerjaan sekarang. <br><br>Demikian penjelasan dari saya, terima kasih.",
    authorImage: "https://media.licdn.com/dms/image/C5603AQEHODnQPoOptA/profile-displayphoto-shrink_800_800/0/1664038875538?e=2147483647&v=beta&t=prr_e0NGr-JGjVr_WQItJkVWHjc1bgxd7wTfElpFMWg"
)

var profileModelUpdateMock = ProfileModel(
    author: "Djaka Permana",
    email: "djakapermana95@gmail.com",
    currentJob: " iOS Developer",
    description: "",
    authorImage: "https://media.licdn.com/dms/image/C5603AQEHODnQPoOptA/profile-displayphoto-shrink_800_800/0/1664038875538?e=2147483647&v=beta&t=prr_e0NGr-JGjVr_WQItJkVWHjc1bgxd7wTfElpFMWg"
)
