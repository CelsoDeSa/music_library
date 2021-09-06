// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

let artistsArray = [];
let apiUrl = 'https://moat.ai/api/task';

function displayArtists() {
	artistsArray.forEach((artist) => {
		const name = artist[0].name;
		const option = document.createElement('option');
		option.setAttribute('value', name);
		option.innerHTML = name;

		document.body.querySelector('select').appendChild(option);
	});
}

async function getArtists() {
	try {
		const response = await fetch(apiUrl, {
			method: 'GET',
			headers: {
				Authorization: 'none',
				Basic: 'ZGV2ZWxvcGVyOlpHVjJaV3h2Y0dWeQ==',
			},
		});
		artistsArray = await response.json();
		displayArtists();
	} catch (error) {
		console.log('whoops, error here:', error);
	}
}

getArtists();