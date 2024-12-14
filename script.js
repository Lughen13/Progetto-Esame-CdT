document.addEventListener('DOMContentLoaded', () => {
    const filters = document.querySelectorAll('#tagList li a'); // Filtri nella barra laterale
  
    filters.forEach(filter => {
      filter.addEventListener('click', event => {
        event.preventDefault();  // Previene il comportamento predefinito dei link
  
        const filterId = filter.id; // ID del filtro selezionato (es. "placeName", "persName", etc.)
  
        // Trova tutti gli span corrispondenti al filtro
        const spans = document.querySelectorAll(`span[data-filter="${filterId}"]`);
  
        // Aggiungi o rimuovi la classe 'highlighted' per gli span corrispondenti
        spans.forEach(span => {
          span.classList.toggle('highlighted');
        });
  
        // Cambia lo stato del filtro nella barra laterale (aggiungi/rimuovi la classe 'active')
        filter.classList.toggle('active');
      });
    });
  });

 // Gestione del click sulle aree
 document.querySelectorAll('area').forEach(area => {
  area.addEventListener('click', function (event) {
  
      // Identifica lo span target tramite l'attributo href
      const targetId = this.getAttribute('id'); // Ad esempio: "tit-pio"
      const targetSpan = document.querySelector(`[id="#${targetId}"]`); // Seleziona elemento con id che include il #

      if (targetSpan) {
          // Aggiungi classe highlight per evidenziare
          targetSpan.classList.add('highlight1');

          // Rimuovi classe highlight dopo qualche secondo
          setTimeout(() => {
              targetSpan.classList.remove('highlight1');
          }, 2000); // 2 secondi
      }
  });
});


function toggleChoice() {
  const choices = document.querySelectorAll('.choice');
  choices.forEach(choice => {
    const sic = choice.querySelector('.sic');
    const corr = choice.querySelector('.corr');
    if (sic.style.display === 'none') {
      sic.style.display = 'inline';
      corr.style.display = 'none';
    } else {
      sic.style.display = 'none';
      corr.style.display = 'inline';
    }
  });
}  

  



  

  
  