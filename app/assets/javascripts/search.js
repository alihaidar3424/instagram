document.addEventListener('turbolinks:load', () => {
  $input = $( "[data-behavior='autocomplete']")

  var options = {
    getValue: 'name',
    url: (phrase) => {
      return '/search.json?q=' + phrase
    },

    categories: [
      {
        listLocation: 'users',
      }
    ],
    list: {
      onChooseEvent: () => {
        var url = $input.getSelectedItemData().url
        $input.val('')
        Turbolinks.visit(url)
      }
    }
  }

  $input.easyAutocomplete(options)
});
