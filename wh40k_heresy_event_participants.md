# Warhammer 40,000 Horus Heresy Event Participants
## Corrected participant dataset and graph-ingestion guidance

> **Purpose:** Seed a graph database that visualizes connections between Horus Heresy-era events and their participants.
>
> **Important:** This document intentionally distinguishes **direct physical participation** from strategic, supporting, contextual, or supernatural involvement. Do not convert every lore association into `PARTICIPATED_IN`.

---

# 1. Participation rules

Use these definitions when creating graph edges:

- **DIRECT** — The source explicitly places the individual/force at the event or has them directly act in it.
- **SUPPORTING** — Directly involved in the operation but not necessarily physically present at the main confrontation.
- **STRATEGIC** — Gave orders, coordinated, dispatched forces, or otherwise influenced the event without physically participating.
- **CONTEXT** — Related to the event through the wider story/history, but should NOT receive a normal participation edge.
- **VISION / PSYCHIC / MANIFESTATION** — Supernatural, psychic, Warp, or vision-based appearance. Do not model as ordinary physical participation.
- **AFTERMATH** — Involved only after the main event.
- **REINFORCEMENT / APPROACHING** — A force/person is moving toward the event but has not necessarily arrived.

For a graph database, a useful relationship shape is:

```text
(Person)-[:INVOLVED_IN {
    relation: "combatant",
    side: "loyalist",
    presence: "physical",
    phase: "main-battle",
    source: "Lexicanum / primary source"
}]->(Event)
```

Recommended `presence` / `relation` values:

```text
physical
strategic
supporting
observer
emissary
planner
psychic
vision
aftermath
reinforcement
approaching
```

Do **not** infer participation merely because:
1. a person appears elsewhere in the same novel,
2. a person commanded the wider campaign,
3. a person is involved in the consequences,
4. a person's Legion is involved,
5. a person is mentioned in narration,
6. a person appears in a vision or Warp manifestation.

---

# 2. Event: Triumph at Ullanor

**ID:** `triumph-at-ullanor`  
**Era:** Great Crusade  
**Location:** Ullanor

## DIRECT — named individuals

```text
Emperor of Mankind
Horus Lupercal
Sanguinius
Mortarion
Magnus the Red
Angron
Jaghatai Khan
Lorgar Aurelian
Rogal Dorn
Fulgrim
Malcador the Sigillite
Constantin Valdor
```

## DIRECT — forces represented

```text
Luna Wolves
Blood Angels
Death Guard
Thousand Sons
World Eaters
White Scars
Word Bearers
Imperial Fists
Emperor's Children
Raven Guard
Salamanders
Ultramarines
Iron Hands
Dark Angels

Imperial Army
Imperial Armada
Titan Legions / Collegia Titanica
Adeptus Custodes
Sisters of Silence
Mechanicum
```

## DO NOT mark as direct Triumph participants

```text
Roboute Guilliman
Ezekyle Abaddon
Ullrak/Urrlak
Urg
Goff Dakka
```

Reason: these names belong to the preceding Ullanor campaign/assault or wider story rather than the actual Triumph attendee list.

> **Important modeling note:** The Triumph is the celebration/parade after the Ullanor Crusade. If the database separately models the Ullanor campaign, campaign participants should be attached to that event, not automatically to the Triumph ceremony.

**Source:**  
https://wh40k.lexicanum.com/wiki/Ullanor_Triumph

---

# 3. Event: Censure at Monarchia

**ID:** `censure-at-monarchia`  
**Era:** Great Crusade  
**Location:** Monarchia, Khur

## DIRECT — named individuals

```text
Emperor of Mankind
Lorgar Aurelian
Roboute Guilliman
Malcador the Sigillite
Argel Tal
Xaphen
```

## DIRECT — forces

```text
Word Bearers Legion
Ultramarines Legion
```

The entire Word Bearers Legion was assembled in the ashes of Monarchia and forced to kneel.

## DO NOT automatically attach as participants

```text
Erebus
Kor Phaeron
Cyrene Valantion
```

Reason: they are highly important to Monarchia and its consequences, but their later roles should not be collapsed into direct participation in the censure itself without an event-specific source establishing physical presence.

**Sources:**  
https://wh40k.lexicanum.com/wiki/Monarchia  
https://wh40k.lexicanum.com/wiki/Word_Bearer

---

# 4. Event: Council of Nikaea

**ID:** `council-of-nikaea`  
**Era:** Great Crusade  
**Location:** Nikaea

> **Important:** Use the event-specific attendee list as the main whitelist for this event.

## DIRECT — named attendees

```text
Ahzek Ahriman
Amon
Amon Tauromachian
Nassir Amit
Aun Helwintr
Bjorn
Calas Typhon
Constantin Valdor
Corvus Corax
Eidolon
Elikas
Emperor of Mankind
Fulgrim
Kasper Hawser
Kelbor-Hal
Leman Russ
Magnus the Red
Mahavastu Kallimakus
Malcador the Sigillite
Mortarion
Othere Wyrdmake
Promus
Raldoron
Rogal Dorn
Sanguinius
Targutai Yesugei
Thoros
Umojen
Vespasian
Zharost
Jalisco de Jerichos Huerta
Tabor Ludovicia
Haldane Ma'lon
Constansa Suati-Falkan
```

## DIRECT — representatives whose names are not given

```text
Iron Warriors representative
World Eaters representative
Sons of Horus representative
Iron Hands representative
Word Bearers representative
Alpha Legion representative
Master of Navigators
```

## DIRECT — institutional/security forces

```text
Adeptus Custodes
Sisters of Silence
Space Wolves
Imperial Fleet
Hegemonic Corps
Various Legion contingents
Astropaths
Librarians
```

## Special identity/deception case: Amon

Do not blindly merge every reference to "Amon" into one ordinary physical participant.

A useful modeling approach is:

```text
Amon Tauromachian
    -> ATTENDED -> Council of Nikaea

Daemon impersonating Amon
    -> DECEPTION_AT -> Council of Nikaea
```

## Important exclusions / distinctions

```text
Perturabo
```

Do not attach Perturabo as an attendee merely because he was involved with the construction/design of the council facilities. If desired, use a `CONTRIBUTED_TO` or `CONSTRUCTED_FOR` style relationship instead.

**Source:**  
https://wh40k.lexicanum.com/wiki/Council_of_Nikaea

---

# 5. Event: The Fall at Davin

**ID:** `davin`  
**Era:** Heresy  
**Location:** Davin

For graphing purposes, treat this event as covering:
1. the Battle of Davin's Moon,
2. Horus being wounded by the Anathame,
3. the Serpent Lodge ritual and corruption of Horus.

## DIRECT — core participants

```text
Horus Lupercal
Eugan/Eugen Temba
Erebus
Akshub
```

## DIRECT / SUPPORTING — Sons of Horus personnel

```text
Ezekyle Abaddon
Horus Aximand
Garviel Loken
Tarik Torgaddon
```

The Mournival and other Sons of Horus personnel are directly involved in handling the wounded Horus and the events surrounding his recovery and journey to the Serpent Lodge.

## DIRECT — forces / organizations

```text
Sons of Horus / 63rd Expedition
Davin / Davin's Moon forces
Imperial Army
Legio Mortis
Serpent Lodge
Davinite plague forces / zombie hordes
```

The initial attack involved approximately 400 Astartes, 4,000 Imperial Army troops and three Titans of Legio Mortis.

## DO NOT mark as ordinary physical participants

```text
Magnus the Red
Ignace Karkasy
Mersadie Oliton
Euphrati Keeler
Petronella Vivar
Kyril Sindermann
Ing Mae Sing
```

Some of these characters belong to the surrounding *False Gods* narrative. Magnus is a special case: use a psychic/visionary relationship if needed, not normal physical participation.

**Sources:**  
https://wh40k.lexicanum.com/wiki/Battle_of_Davin%27s_Moon  
https://wh40k.lexicanum.com/wiki/False_Gods_(Novel)

---

# 6. Event: Isstvan III

**ID:** `isstvan-iii`  
**Era:** Heresy  
**Location:** Isstvan III

## TRAITOR SIDE — named participants

```text
Horus Lupercal
Ezekyle Abaddon
Horus Aximand
Angron
Khârn
Mortarion
Calas Typhon
Durak Rask
Eidolon
Charmosion
Esau Turnet
```

## LOYALIST SIDE — named participants

```text
Garviel Loken
Tarik Torgaddon
Saul Tarvitz
Abdemon
Lucius
Rylanor
Ehrlen
Shabran Darr
Ullis Temeter
Crysos Morturg
Calleb Decima
Vardus Praal
Nathaniel Garro
```

## DIRECT — forces

```text
Sons of Horus
Death Guard
Emperor's Children
World Eaters

Loyalist elements of:
  Sons of Horus
  Death Guard
  Emperor's Children
  World Eaters

Legio Mortis
Legio Audax
Legio Vulpa
Ordo Reductor

Isstvanian rebel forces
Warsingers
Imperial Army
```

## IMPORTANT EXCLUSIONS

```text
Iacton Qruze
Fulgrim
Malcador the Sigillite
```

Do not attach these as normal direct participants in the battle solely because of their broader connections to the 63rd Expedition / Heresy narrative.

In particular, Fulgrim was dispatched away from the immediate Isstvan III operation.

**Source:**  
https://wh40k.lexicanum.com/wiki/Battle_of_Isstvan_III

---

# 7. Event: Isstvan V — Dropsite Massacre

**ID:** `isstvan-v`  
**Era:** Heresy  
**Location:** Isstvan V

## LOYALIST PRIMARCHS

```text
Ferrus Manus
Corvus Corax
Vulkan
```

## TRAITOR PRIMARCHS

```text
Horus Lupercal
Fulgrim
Angron
Mortarion
Lorgar Aurelian
Konrad Curze
```

## LOYALIST — named participants

```text
Gabriel Santar
Castrmen Orth

Agapito Nev
Alvarex Maun

Artellus Numeon
Cassian Dracos
Arik Xergoh

Saturnyne Rams
Phera Ikaeron
Admiral Klave
Koros Kadorikus
```

## TRAITOR — named participants

```text
Ezekyle Abaddon
Horus Aximand

Julius Kaesoron
Marius Vairosean
Eidolon
Lucius

Khârn

Calas Typhon

Kor Phaeron
Erebus
Argel Tal

Jago Sevatarion

Morthax

Perturabo
Forrix
Harkor
Erasmus Golg
Ked Rordram

Alpharius
Omegon
Ingo Pech
```

## OTHER DIRECT / COVERT PARTICIPANTS

```text
Marcus Valerius
Branne
Hesperides
Xaliscus
Grelth
Lord Commander Fayle
```

## DIRECT — forces

```text
Iron Hands
Salamanders
Raven Guard

Sons of Horus
Emperor's Children
World Eaters
Death Guard
Word Bearers
Night Lords
Iron Warriors
Alpha Legion

Imperial Army
Traitor Army
Mechanicum
Dark Mechanicum
Titan Legions
Legio Mortis
```

## IMPORTANT EXCLUSIONS

Do NOT mark as physical participants merely due to strategic involvement:

```text
Rogal Dorn
Malcador the Sigillite
Roboute Guilliman
Sanguinius
Lion El'Jonson
```

If needed, represent these as strategic/coordinating relationships rather than physical participation.

**Source:**  
https://wh40k.lexicanum.com/wiki/Drop_Site_Massacre

---

# 8. Event: Burning of Prospero

**ID:** `burning-of-prospero`  
**Era:** Heresy  
**Location:** Prospero

## IMPERIAL / LOYALIST — named participants

```text
Leman Russ
Othere Wyrdmake
Aun Helwintr
Jormungndr
Bjorn
Godsmote
Kasper Hawser
Geigor Fell-Hand

Constantin Valdor
Amon Tauromachian

Jenetia Krole

Thrane Esmark
Maldis Drane

Boros Kurn
```

## THOUSAND SONS — named participants

```text
Magnus the Red
Ahzek Ahriman
Phosis T'Kar
Hathor Maat
Khalophis
Phael Toron
Auramagma
Amon
Ankhu Anen
Sobek
```

## DIRECT — forces

```text
Space Wolves
Thousand Sons
Adeptus Custodes
Sisters of Silence
Imperial Army / Solar Auxilia
Mechanicum
Prospero Spireguard
Prosperine citizen militia
Legio Mortis
Ordo Sinister
Taghmata
```

## REMOVE / DO NOT AUTO-ADD from generic campaign material

```text
Princeps Calvar Ibranum
Magos Tacitus Proctor
Legio Xestobiax
```

These were not supported by the event-specific roster used for this corrected pass.

Also do not add:

```text
Horus Lupercal
Alpha Legion
```

as physical participants merely because they are involved in the wider Thousand Sons / Space Wolves storyline.

**Source:**  
https://wh40k.lexicanum.com/wiki/Burning_of_Prospero

---

# 9. Event: Battle of Calth

**ID:** `battle-of-calth`  
**Era:** Heresy  
**Location:** Calth, Ultramar

## WORD BEARERS — named participants

```text
Lorgar Aurelian
Kor Phaeron
Foedrall Fell
Erebus
Hol Beloth
Morpal Cxir
Maloq Kartho
Sorot Tchure
Kurtha Sedd
Zardu Layak
```

## ULTRAMARINES — named participants

```text
Roboute Guilliman
Eikos Lamiad
Tauro Nicodemus
Marius Gage
Remus Ventanus
Klord Empion
Saur Damocles
Steloc Aethon
Erikon Gaius
Teus Sullus
Lyros Sydance
Aurian
Honorius Luciel
Aeonid Thiel
Anchise
Arook Serotid
```

## OTHER DIRECT PARTICIPANTS

```text
Meer Edv Tawren
Colonel Sparzi
Magos Cronn Barbarel
```

## DIRECT — forces

```text
Ultramarines Legion
Word Bearers Legion
Gal Vorbak
Word Bearers fleet
Ultramarines fleet
Imperial Army / Auxilia
Mechanicum
Skitarii
Titan Legions
Daemons
Cultists
Legio Suturvora
```

## IMPORTANT EXCLUSIONS

```text
Ollanius Persson
John Grammaticus
```

Do not attach them as Battle of Calth participants merely because they are important elsewhere in the Horus Heresy timeline.

Also treat:

```text
Lysimachus Cestus
```

carefully. His involvement in the *Furious Abyss* thread should not automatically become a participation edge for the ground battle at Calth.

**Sources:**  
https://wh40k.lexicanum.com/wiki/Battle_for_Calth  
https://wh40k.lexicanum.com/wiki/Marius_Gage

---

# 10. Event: Signus Campaign

**ID:** `signus-campaign`  
**Era:** Heresy  
**Location:** Signus Cluster

## BLOOD ANGELS / IMPERIAL — named participants

```text
Sanguinius
Raldoron
Azkaellon
Dahka Berus
Nassir Amit
Yason Annellus
Mkani Kano
Meros
Athene DuCade
Helik Redknife
Nakir
Maulgrehn
Jerick Halbeth
Betric Sizal
Aster Crohne
Barbiel
Erane Shurol
Debeeran Kalimakon
```

## CHAOS — named participants

```text
Ka'Bandha
Kyriss the Perverse
Tanus Kreed
Ygethddon
```

## DIRECT — forces

```text
Blood Angels
Imperial Armada
Space Wolves detachment
Adeptus Custodes
Narthex Cull Imperial Army regiments
Legio Cybernetica
Word Bearers
Daemonic hordes
Cultists
Elements of:
  Sons of Horus
  Night Lords
  World Eaters
```

## IMPORTANT EXCLUSION

Do NOT mark as physical participants:

```text
Horus Lupercal
Erebus
```

They are involved in dispatching/planning/advising the operation but were not physically present at Signus.

Suggested graph relationships:

```text
Horus --[STRATEGIC/DISPATCHED]--> Signus Campaign
Erebus --[ADVISED]--> Signus Campaign
Blood Angels --[PARTICIPATED]--> Signus Campaign
```

**Source:**  
https://wh40k.lexicanum.com/wiki/Battle_of_Signus_Prime

---

# 11. Event: Battle of Phall

**ID:** `battle-of-phall`  
**Era:** Heresy  
**Location:** Phall

## IRON WARRIORS — direct participants

```text
Perturabo
Forrix
Berossus
Erasmus Golg
Varrek
```

## IMPERIAL FISTS — direct participants

```text
Alexis Polux
Amandus Tyr
Pertinax
Scallus
Captain Yonnad
```

## DIRECT — forces

```text
Iron Warriors
Imperial Fists
Sol System Imperial Army
Saturnine Fleet Reserves
```

## CRITICAL EXCLUSIONS

```text
Sigismund
Rogal Dorn
```

Do NOT mark Sigismund as a physical participant in the Battle of Phall.

Sigismund was originally intended to lead the Retribution Fleet but did not go to Phall; command passed to Captain Yonnad.

Dorn issued strategic orders but was not physically fighting at Phall.

Suggested graph:

```text
Rogal Dorn --[STRATEGIC/ORDERED]--> Battle of Phall
Sigismund --[PLANNED/INTENDED COMMAND]--> Battle of Phall
Captain Yonnad --[DIRECT COMMANDER]--> Battle of Phall
```

**Source:**  
https://wh40k.lexicanum.com/wiki/Battle_of_Phall

---

# 12. Event: Thramas Crusade

**ID:** `thramas-crusade`  
**Era:** Heresy  
**Location:** Thramas Sector

> This is a **campaign**, not one single battle. A larger participant roster is therefore appropriate.

## DARK ANGELS — named participants

```text
Lion El'Jonson
Alajos
Corswain
Marduk Sedras
Bujir Khan
Mayvin Khelen
Arcturus Morhde
```

## NIGHT LORDS — named participants

```text
Konrad Curze
Jago Sevatarion
Alastor Rushal
Var Jahan
Malithos Kuln
Ithillion
Jexad
Shoma
Cel Herec
Kheron Ophion
Naraka
Krukesh
Tovac Tor
Shang
Nakrid Thole
Anrek Barbatos
Witch of Thramas
```

## WHITE SCARS — named participant

```text
Zhenjin Khan
```

Zhenjin Khan is a particularly important identity/allegiance edge for graph purposes because his allegiance changes during the wider campaign material.

## DIRECT — forces

```text
Dark Angels
Night Lords
White Scars
Ultramarines contingent
Thramassi Nightwatch
Loyalist Mechanicum / Taghmata
Traitor Mechanicum / Taghmata
Legio Solaria
Legio Victorum
Legio Phasma
Legio Adamantus
Legio Atrox
Legio Saevus
Lost and the Damned
Ulan Huda
```

## SPECIAL UNITS / ENTITIES

```text
Excindio
Deathwing Companions
```

**Source:**  
https://wh40k.lexicanum.com/wiki/Thramas_Crusade

---

# 13. Event: Siege of Terra

**ID:** `siege-of-terra`  
**Era:** Heresy  
**Location:** Terra

> **Strong modeling recommendation:** Treat `siege-of-terra` as a parent event and represent major battles/phases as child events. The participant set changes over time.

Recommended event hierarchy:

```text
Siege of Terra
├── Solar War
├── Battle of the Lion's Gate
├── Saturnine
├── Eternity Gate battles
├── Inner Palace battles
├── Final assault
├── Boarding of the Vengeful Spirit
└── Other phase-specific battles
```

## LOYALIST — named participants

```text
Emperor of Mankind
Malcador the Sigillite
Rogal Dorn
Sanguinius
Jaghatai Khan
Vulkan
Constantin Valdor

Amon Tauromachian
Tsutomu
Diocletian Coros
Caecaltus Dusk
Jenetia Krole
Aphone Ire

Sigismund
Archamus
Fafnir Rann
Camba Diaz
Maximus Thane
Fisk Halen
Vorst
Diamantis
Sevastin Haeger
Honfler

Raldoron
Azkaellon
Nassir Amit
Zephon
Bel Sepatus
Anzarael
Khoradal Furio
Idamas
Satel Aimery
Emhon Lux

Qin Fai Noyan-Khan
Ganzorig Noyan-Khan
Shiban Khan
Jangsai Khan
Naranbaatar
Namahi

Corswain
Adophel
Tragan

Bodvar Bjarki
Atok Abidemi
Igen Gargo

Barek Zytos
Zagreus Kane
Cydon
Esha Ani Mohana
Aurum

Adreen
Saul Niborran
Konas Burr
Ilya Ravallion
Katarin Elg
Sandrine Icaro
Aldana Agathe
Yennu Egwu
Nasuba
Clement Brohn

Garviel Loken
Nathaniel Garro

Lord Cypher
Actae
Ollanius Persson
Leetu
```

## TRAITOR — named participants

```text
Horus Lupercal
Perturabo
Angron
Magnus the Red
Fulgrim
Mortarion

Kelbor-Hal

Ezekyle Abaddon
Horus Aximand
Falkus Kibre
Tormageddon
Tybalt Marr
Lev Goshen
Azelas Baraxa
Indras Archeta
Xhofar Beruddin
Lycas Fyton
Malabreux
Hellas Sycar
Taras Balt
Vorus Ikari
Selgar Dorgaddon
Kalintus
Zistrion
Ekron Fal

Erebus
Zardu Layak
Inzar Taerus

Typhus
Caipha Morarg
Gremus Kalgaro
Zadal Crosius
Skulidas Gehrerg

Khârn
Shâhka

Ahzek Ahriman
Amon
Ignis

Forrix
Kroeger
Barban Falk
Ormon Gundar
Bogdan Mortel

Gendor Skraivok
Krostovok

Eidolon
Cyrius
Fabius

Ka'Bandha
Cor'bax Utterblight
Vassukella
Sota-Nul
Ardim Protos
Axmar Tre
Clain Pent
Illivia Epta
Inar Satarael
```

## SUPPORTING / TERRAN / SPECIALIST personnel

```text
Julius Gundelfo
Osaka
Montesere
Brinlaw
Perez Grist
Lin-Hu Kway
Sator Omes
Arnolf Van Halmere
Hyton Ki
```

Treat these more as supporting/preparatory personnel rather than putting them visually on the same level as Primarchs and major battlefield commanders.

## DIRECT — forces

### Loyalist

```text
Imperial Fists
Blood Angels
White Scars
Salamanders
Dark Angels contingent
Space Wolves elements
Adeptus Custodes
Sisters of Silence
Knights-Errant
Blackshields
Shattered Legions
Imperial Army
Solar Auxilia
Mechanicum
Titan Legions
Knight Houses
Legio Cybernetica
```

### Traitor

```text
Sons of Horus
Death Guard
World Eaters
Emperor's Children
Iron Warriors
Thousand Sons
Traitor Mechanicum
Dark Mechanicum
Traitor Titan Legions
Traitor Knights
Daemons
Lost and the Damned
Traitor Imperial Army
```

## IMPORTANT ABSENCE / QUALIFIERS

Do NOT mark the following as ordinary physically-present main Siege participants merely because their forces or strategic decisions are relevant:

```text
Roboute Guilliman
Leman Russ
Lion El'Jonson
```

Useful distinctions:

```text
Roboute Guilliman -> reinforcement / approaching
Leman Russ -> absent from main Siege
Lion El'Jonson -> absent from Terra; Dark Angels contingent under Corswain is present
```

Also, do not assume all Traitor Primarchs listed above are present for the entire duration. Their participation is phase-dependent and should ideally have time/phase metadata.

Suggested relationship example:

```text
Perturabo --[PARTICIPATED_IN {
    phase: "early/mid Siege",
    status: "active",
    presence: "physical"
}]--> Siege of Terra
```

rather than treating the entire Siege as one timeless state.

**Sources:**  
https://wh40k.lexicanum.com/wiki/Siege_of_the_Imperial_Palace  
https://wh40k.lexicanum.com/wiki/Siege_of_Terra

---

# 14. Event: Boarding of the Vengeful Spirit

**ID:** `boarding-vengeful-spirit`  
**Era:** Heresy  
**Location:** Vengeful Spirit, above Terra

> Distinguish between **the actual boarding party** and people supporting simultaneous operations elsewhere on Terra.

## ACTUAL LOYALIST BOARDING GROUPS

### Emperor's group

```text
Emperor of Mankind
Hetaeron Guard
```

### Valdor's group

```text
Constantin Valdor
Adeptus Custodes
```

### Sanguinius' group

```text
Sanguinius
Raldoron
Sanguinary Guard
Blood Angels 1st Company
```

### Dorn's group

```text
Rogal Dorn
Diamantis
Huscarls
```

These four groups form the principal loyalist assault force that boards the *Vengeful Spirit*.

## TRAITOR / SHIP-SIDE PARTICIPANTS

```text
Horus Lupercal
Ezekyle Abaddon
Erebus
Kenor Argonis
Sons of Horus
Word Bearers
Daemonic forces
```

## LATE-PHASE DIRECT PARTICIPANTS

If the event definition includes the entire final sequence of fighting aboard/within the *Vengeful Spirit*, include:

```text
Garviel Loken
Leetu
Ollanius Persson
```

## SUPPORTING — DO NOT MARK AS BOARDERS

```text
Malcador the Sigillite
Vulkan
Archamus
Corswain
Lord Cypher
Typhus
```

Examples:

```text
Malcador --[SUPPORTING]--> Boarding of Vengeful Spirit
Vulkan --[REMAINED_AT_TERRA]--> Boarding of Vengeful Spirit
Archamus --[COMMANDING_REMAINING_FORCES]--> Boarding of Vengeful Spirit
Corswain --[SIMULTANEOUS_OPERATION]--> Boarding of Vengeful Spirit
Lord Cypher --[SIMULTANEOUS_OPERATION]--> Boarding of Vengeful Spirit
Typhus --[SIMULTANEOUS_OPERATION]--> Boarding of Vengeful Spirit
```

## SUPERNATURAL / VISIONARY ENTITIES

Do not automatically treat these as ordinary physical participants:

```text
Ferrus Manus
Hastur Sejanus
Zardu Layak when appearing as a vision/manifestation
```

Use a relationship such as:

```text
VISION_OF
MANIFESTATION
WARP_ECHO
PSYCHIC_CONTACT
```

where appropriate.

**Sources:**  
https://wh40k.lexicanum.com/wiki/Siege_of_the_Imperial_Palace  
https://wh40k.lexicanum.com/wiki/Battle_of_Terra

---

# 15. Known corrections from the earlier pass

The following were specifically identified as false-positive / over-broad edges and should be corrected in any existing database.

| Event | Remove / change | Reason |
|---|---|---|
| Triumph at Ullanor | Roboute Guilliman | Ullanor Crusade commander, not Triumph attendee |
| Triumph at Ullanor | Abaddon / Ork commanders as ceremony attendees | Campaign participation ≠ Triumph ceremony attendance |
| Censure at Monarchia | Erebus / Kor Phaeron | Important later figures, but not established as direct censure participants |
| Council of Nikaea | Various omitted attendees | Actual attendee list is much larger |
| Council of Nikaea | Perturabo as attendee | Construction/design association ≠ attendance |
| Davin | Remembrancers / wider *False Gods* cast | Surrounding narrative ≠ participation in Horus' fall |
| Isstvan III | Iacton Qruze | Not established by the event-specific battle roster as direct participant |
| Isstvan III | Fulgrim | Dispatched away from immediate operation |
| Isstvan V | Dorn / Malcador / Guilliman / Sanguinius / Lion | Strategic/contextual involvement, not physical Drop Site participation |
| Prospero | Calvar Ibranum / Tacitus Proctor / Legio Xestobiax | Not supported by the event-specific roster used here |
| Calth | Ollanius Persson / John Grammaticus | Not Calth battle participants |
| Signus | Horus / Erebus as physical participants | They dispatched/advised; they were not physically at Signus |
| Phall | Sigismund | Intended/expected command role, but did not go to Phall |
| Phall | Rogal Dorn | Strategic commander, not physically at Phall |
| Siege of Terra | Guilliman / Russ / Lion as ordinary physical main defenders | Their forces/strategic relevance does not mean the individual was physically present |
| Vengeful Spirit | Azkaellon | Important Blood Angel, but not one of the named principal boarding-party commanders in the boarding account |
| Vengeful Spirit | Vulkan | Remained on Terra; did not board |
| Vengeful Spirit | Malcador | Supported the operation from the Golden Throne rather than boarding |

---

# 16. Recommended graph schema

A simple:

```text
(Person)-[:PARTICIPATED_IN]->(Event)
```

is too lossy for Heresy lore.

Prefer:

```text
(Person)-[:INVOLVED_IN {
    role: "...",
    side: "...",
    presence: "...",
    phase: "...",
    source: "..."
}]->(Event)
```

Example:

```text
(Sigismund)-[:INVOLVED_IN {
    role: "intended commander",
    side: "loyalist",
    presence: "not-present",
    relation: "planned-command",
    source: "Lexicanum"
}]->(Phall)
```

```text
(Captain Yonnad)-[:INVOLVED_IN {
    role: "commander",
    side: "loyalist",
    presence: "physical",
    relation: "direct"
}]->(Phall)
```

```text
(Horus)-[:INVOLVED_IN {
    role: "dispatcher",
    side: "traitor",
    presence: "remote",
    relation: "strategic"
}]->(Signus Campaign)
```

```text
(Sanguinius)-[:INVOLVED_IN {
    role: "Primarch / commander",
    side: "loyalist",
    presence: "physical",
    relation: "direct"
}]->(Signus Campaign)
```

---

# 17. Source policy for future event expansion

Recommended source hierarchy:

1. **Primary source** — Codex, Black Library novel, campaign book, rulebook, official GW publication.
2. **Lexicanum event-specific article** — use as the index and cross-reference, especially its attendee/order-of-battle sections.
3. Other fan wikis — useful for discovery, but verify important claims against primary material.
4. Forums / Reddit / YouTube — discovery only; do not use as the final factual authority for participant edges.

A particularly important Heresy rule:

> **When a source gives an explicit attendee/order-of-battle list, treat it as a whitelist. Do not scan the entire article and convert every named person into a participant.**

Also preserve contradictory accounts rather than silently merging them. The Horus Heresy contains edition changes, retcons, conflicting accounts, unreliable narrators, and differing source presentations.

Where possible, store:

```text
source
publication
chapter/page (if known)
date/edition (if relevant)
relationship_type
presence
phase
notes
```

This will make it possible to resolve lore disputes without corrupting the underlying graph.

---

# 18. Event IDs supplied by the project

```text
triumph-at-ullanor
censure-at-monarchia
council-of-nikaea
davin
isstvan-iii
isstvan-v
burning-of-prospero
battle-of-calth
signus-campaign
battle-of-phall
thramas-crusade
siege-of-terra
boarding-vengeful-spirit
```

---

# 19. Primary research links used for this pass

```text
https://wh40k.lexicanum.com/wiki/Ullanor_Triumph
https://wh40k.lexicanum.com/wiki/Monarchia
https://wh40k.lexicanum.com/wiki/Council_of_Nikaea
https://wh40k.lexicanum.com/wiki/Battle_of_Davin%27s_Moon
https://wh40k.lexicanum.com/wiki/False_Gods_(Novel)
https://wh40k.lexicanum.com/wiki/Battle_of_Isstvan_III
https://wh40k.lexicanum.com/wiki/Drop_Site_Massacre
https://wh40k.lexicanum.com/wiki/Burning_of_Prospero
https://wh40k.lexicanum.com/wiki/Battle_for_Calth
https://wh40k.lexicanum.com/wiki/Marius_Gage
https://wh40k.lexicanum.com/wiki/Battle_of_Signus_Prime
https://wh40k.lexicanum.com/wiki/Battle_of_Phall
https://wh40k.lexicanum.com/wiki/Thramas_Crusade
https://wh40k.lexicanum.com/wiki/Siege_of_the_Imperial_Palace
https://wh40k.lexicanum.com/wiki/Siege_of_Terra
https://wh40k.lexicanum.com/wiki/Battle_of_Terra
```

---

## Final implementation warning

This document is a **curated corrected participant set**, not a claim that every individual listed has the same degree of involvement.

For the actual graph, preserve the distinction between:

```text
DIRECT PHYSICAL PARTICIPANT
DIRECT SUPPORT
STRATEGIC / REMOTE INVOLVEMENT
CAMPAIGN-LEVEL ASSOCIATION
AFTERMATH
VISION / WARP / PSYCHIC APPEARANCE
```

That distinction is essential to avoid contaminating the visualization with false "person was here" edges.
