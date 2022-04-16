# Pocasie

iOS :iphone: aplilkácia v rámci kurzu L2C :books: na sledovanie počasia :sun_behind_rain_cloud: v nadefinovaných lokalitách :compass:.  
Aplikácia sťahuje dáta o počasí v reálnom čase z [OpenWeatherMap.org](https://openweathermap.org) vo formáte JSON.
  
Za pomoci mágie :crystal_ball: a čarov :magic_wand: ich zobrazíme na displayi iPhonu alebo iPadu.  
Veľmi ľahko si ukážeme prácu s MapKit-om :world_map:.
Zameriame sa na parsovanie dát zo vzdialeného servera a súboru JSON do podoby s ktorou vieme pracovať.
Jemne sa pozrieme aj na softvérovú architektúru :building_construction:, konkrétne MVVM.

![Pocasie screenshot](https://github.com/pavelsurovy/Pocasie/blob/main/Pocasie%20screenshot.png)

# Úloha

## Vytvoriť svoju vlastnú aplikáciu!
Na stránke [https://api.nasa.gov](https://api.nasa.gov) si vyhľadajte APOD - Astronomy Picture of the Day :milky_way:, teda API pre túto stránku [https://apod.nasa.gov/apod/astropix.html](https://apod.nasa.gov/apod/astropix.html). Nie je potrebné registrovať sa pre API kľúč :key:. Postačuje použiť ich [DEMO_KEY](https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY).

### Chceme:
* fotografiu
* titulok
* popis
* autora

S parametrom [&COUNT=1](https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=1) dostanete vždy random 1 post pri zavolaní.  

**title a copyright nemusia byť vždy súčasťou JSON súboru. Preto je potrebné ich dať ako optional (?)**

Pre získanie obrázka zo vzdialeného servera je potrebné použiť AsyncImage().
```
AsyncImage(url: URL(string: "...")) { image in
    image.resizable()
        .scaledToFit()
} placeholder: {
    Color.gray
        .frame(height: 300)
}
```

Teraz viete všetko :brain: čo je potrebné k vytvoreniu svojej aplikácie. Pustite sa do toho!

Veľa šťastia :four_leaf_clover:
