import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["source", "target"]

  initialize() {
    console.log('Initialized matches controller');
  }

  populateOpponentSelectBox(e, info, sourceId, targetId = null) {
    let el = document.getElementById("game_id");
    var selectedGameId = parseInt(el.options[el.selectedIndex].value);

    let parsedJson = JSON.parse(e.target.dataset.target);
    let gamerProfiles = parsedJson.gamer_profiles;
    let users = parsedJson.users;

    const selectBox = $('#player2_id')[0];
    selectBox.innerHTML = '';

    for (var i = 0; i < gamerProfiles.length; i++) {
      if (gamerProfiles[i].game_id == selectedGameId) {
        let user = users.find(x => x.id == gamerProfiles[i].user_id);

        if (user != null) {
          var opt = document.createElement("option");
          opt.value = user.id;
          opt.innerHTML = user.email;
          selectBox.appendChild(opt);
        }
      }
    }
  }
}