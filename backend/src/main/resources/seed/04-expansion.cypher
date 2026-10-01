// ============================================================================
// EXPANSION — additional notable Heresy-era characters and their relations.
// Idempotent (MERGE on id). Nodes first, then relationships. Lore is original
// high-level summary; contested points go in loreNote.
// ============================================================================

// ---- Astartes (new) -------------------------------------------------------
MERGE (n:Character:Astartes {id: 'maloghurst'})
  SET n.name = 'Maloghurst the Twisted', n.subtitle = 'Equerry of the Warmaster',
      n.description = 'Horus\'s equerry and master of secrets, his body broken in a crash and his loyalty to the Warmaster absolute. He managed the Legion\'s intrigues and the lodges that spread dissent.';
MERGE (n:Character:Astartes {id: 'serghar-targost'})
  SET n.name = 'Serghar Targost', n.subtitle = 'Lodge Master, Sons of Horus',
      n.description = 'Captain and master of the warrior lodge whose secret meetings helped bind the Legion to Horus\'s cause.';
MERGE (n:Character:Astartes {id: 'falkus-kibre'})
  SET n.name = 'Falkus Kibre', n.subtitle = 'Widowmaker, Justaerin Captain',
      n.description = 'Commander of the black-armoured Justaerin Terminators, among the deadliest warriors of the Sons of Horus.';
MERGE (n:Character:Astartes {id: 'tybalt-marr'})
  SET n.name = 'Tybalt Marr', n.subtitle = 'The Either, Sons of Horus',
      n.description = 'A captain of the Sons of Horus, inseparable from his counterpart Verulam Moy until the latter\'s death turned him to cold ambition.';
MERGE (n:Character:Astartes {id: 'kalus-ekaddon'})
  SET n.name = 'Kalus Ekaddon', n.subtitle = 'Catulan Reaver Captain',
      n.description = 'Captain of the Catulan assault squads, a specialist in the lightning boarding actions the Legion favoured.';
MERGE (n:Character:Astartes {id: 'marius-vairosean'})
  SET n.name = 'Marius Vairosean', n.subtitle = 'Captain, Emperor\'s Children',
      n.description = 'A Lord Commander remade by the sonic weapons of the Kakophoni, an early and eager convert to the pursuit of sensation.';
MERGE (n:Character:Astartes {id: 'macer-varren'})
  SET n.name = 'Macer Varren', n.subtitle = 'Captain, World Eaters',
      n.description = 'A blunt, honourable captain of the World Eaters who refused to follow Angron into damnation and escaped to serve the loyalist cause.',
      n.fate = 'Became a Knight-Errant, an agent of the loyalist resistance.',
      n.loreNote = 'A rare loyalist of the World Eaters, later one of Malcador\'s chosen agents.';
MERGE (n:Character:Astartes {id: 'ignatius-grulgor'})
  SET n.name = 'Ignatius Grulgor', n.subtitle = 'Commander, Death Guard',
      n.description = 'A spiteful Death Guard commander whose death aboard the Eisenstein became the first bloom of Nurgle\'s corruption.';
MERGE (n:Character:Astartes {id: 'zardu-layak'})
  SET n.name = 'Zardu Layak', n.subtitle = 'The Crimson Apostle, Word Bearers',
      n.description = 'A masked Dark Apostle and binder of daemons, wielder of two bound soul-slaves, prominent in the final assault on Terra.';
MERGE (n:Character:Astartes {id: 'hol-beloth'})
  SET n.name = 'Hol Beloth', n.subtitle = 'Captain, Word Bearers',
      n.description = 'A rising commander of the Word Bearers who led assaults during the Shadow Crusade against Ultramar.';
MERGE (n:Character:Astartes {id: 'hathor-maat'})
  SET n.name = 'Hathor Maat', n.subtitle = 'Captain, Thousand Sons',
      n.description = 'Captain of the Pavoni cult, master of biomancy and vanity in equal measure, who fought to hold his flesh against the mutating flesh-change.';
MERGE (n:Character:Astartes {id: 'menkaura'})
  SET n.name = 'Menkaura', n.subtitle = 'Librarian, Thousand Sons',
      n.description = 'A seer of the Thousand Sons whose prescience survived the burning of Prospero, though at a terrible cost to his body.';
MERGE (n:Character:Astartes {id: 'forrix'})
  SET n.name = 'Forrix', n.subtitle = 'First Captain, Iron Warriors',
      n.description = 'The Triarch and most senior warsmith beneath Perturabo, a grim master of the breach and the grinding war of attrition.';
MERGE (n:Character:Astartes {id: 'zso-sahaal'})
  SET n.name = 'Zso Sahaal', n.subtitle = 'Talonmaster, Night Lords',
      n.description = 'Curze\'s chosen heir and bearer of his master\'s relics, the Talons of the Night Haunter, captain of the First Company.';
MERGE (n:Character:Astartes {id: 'ingo-pech'})
  SET n.name = 'Ingo Pech', n.subtitle = 'First Captain, Alpha Legion',
      n.description = 'One of the Alpha Legion\'s senior officers, as likely to wear another\'s face as his own in service of the Legion\'s designs.';
MERGE (n:Character:Astartes {id: 'corswain'})
  SET n.name = 'Corswain', n.subtitle = 'Seneschal of the Dark Angels',
      n.description = 'A paladin of the First Legion and the Lion\'s trusted champion, who held the line through the long shadow-war of Thramas.';
MERGE (n:Character:Astartes {id: 'torghun-khan'})
  SET n.name = 'Torghun Khan', n.subtitle = 'Khan of the White Scars',
      n.description = 'A Terran-born khan drawn briefly toward Horus by the lodges, who returned to loyalty and fought to redeem himself.',
      n.loreNote = 'His near-turning dramatises the divided loyalties within the White Scars before the Khan chose the Emperor.';
MERGE (n:Character:Astartes {id: 'bjorn'})
  SET n.name = 'Bjorn the Fell-Handed', n.subtitle = 'Space Wolf of the Heresy',
      n.description = 'A young, ferocious legionary of the Space Wolves who fought at Prospero and would, in ages to come, become the Imperium\'s most venerable Dreadnought.';
MERGE (n:Character:Astartes {id: 'alexis-polux'})
  SET n.name = 'Alexis Polux', n.subtitle = 'Captain, Imperial Fists',
      n.description = 'A gifted void-commander of the Imperial Fists, caught at the heart of the great warp-storm battle at Phall.';
MERGE (n:Character:Astartes {id: 'fafnir-rann'})
  SET n.name = 'Fafnir Rann', n.subtitle = 'Huscarl Captain, Imperial Fists',
      n.description = 'Captain of the first assault cadres and a relentless close-quarters fighter upon the walls of the Imperial Palace.';
MERGE (n:Character:Astartes {id: 'amit'})
  SET n.name = 'Amit', n.subtitle = 'The Flesh Tearer, Blood Angels',
      n.description = 'A captain of the Blood Angels whose savagery in battle both unnerved and preserved his brothers; the seed of a harsher successor Chapter.';
MERGE (n:Character:Astartes {id: 'zephon'})
  SET n.name = 'Zephon', n.subtitle = 'The Bringer of Sorrow, Blood Angels',
      n.description = 'A celebrated Sanguinary Guard who bore wounds of body and spirit, and whom the angel Sanguinius himself would not let despair.';
MERGE (n:Character:Astartes {id: 'autek-mor'})
  SET n.name = 'Autek Mor', n.subtitle = 'Clan Commander, Iron Hands',
      n.description = 'An uncompromising Iron Hands commander who led survivors of his broken Legion in bitter reprisals after Isstvan.';
MERGE (n:Character:Astartes {id: 'aeonid-thiel'})
  SET n.name = 'Aeonid Thiel', n.subtitle = 'Sergeant, Ultramarines',
      n.description = 'A free-thinking sergeant, marked for censure yet proven right, whose counsel helped the Ultramarines weather the treachery at Calth.';
MERGE (n:Character:Astartes {id: 'tylos-rubio'})
  SET n.name = 'Tylos Rubio', n.subtitle = 'Librarian, Ultramarines',
      n.description = 'An Ultramarines Librarian who set aside his psychic powers at Nikaea\'s command, recalled to the fight as one of Malcador\'s agents.',
      n.loreNote = 'Later a Knight-Errant alongside Garro and Varren.';
MERGE (n:Character:Astartes {id: 'nykona-sharrowkyn'})
  SET n.name = 'Nykona Sharrowkyn', n.subtitle = 'Marksman, Raven Guard',
      n.description = 'A silent, deadly shade of the Raven Guard, a peerless marksman and duellist among the survivors of the Dropsite Massacre.';

// ---- MEMBER_OF {role} -----------------------------------------------------
UNWIND [
  ['maloghurst','sons-of-horus','Equerry'],
  ['serghar-targost','sons-of-horus','Lodge Master'],
  ['falkus-kibre','sons-of-horus','Justaerin Captain'],
  ['tybalt-marr','sons-of-horus','Captain'],
  ['kalus-ekaddon','sons-of-horus','Catulan Reaver Captain'],
  ['marius-vairosean','emperors-children','Lord Commander'],
  ['macer-varren','world-eaters','Captain'],
  ['ignatius-grulgor','death-guard','Commander'],
  ['zardu-layak','word-bearers','Dark Apostle'],
  ['hol-beloth','word-bearers','Captain'],
  ['hathor-maat','thousand-sons','Captain'],
  ['menkaura','thousand-sons','Librarian'],
  ['forrix','iron-warriors','First Captain'],
  ['zso-sahaal','night-lords','Talonmaster'],
  ['ingo-pech','alpha-legion','First Captain'],
  ['corswain','dark-angels','Seneschal'],
  ['torghun-khan','white-scars','Khan'],
  ['bjorn','space-wolves','Legionary'],
  ['alexis-polux','imperial-fists','Captain'],
  ['fafnir-rann','imperial-fists','Huscarl Captain'],
  ['amit','blood-angels','Captain'],
  ['zephon','blood-angels','Sanguinary Guard'],
  ['autek-mor','iron-hands','Clan Commander'],
  ['aeonid-thiel','ultramarines','Sergeant'],
  ['tylos-rubio','ultramarines','Librarian'],
  ['nykona-sharrowkyn','raven-guard','Marksman']
] AS m
MATCH (c {id: m[0]}), (l {id: m[1]})
MERGE (c)-[r:MEMBER_OF]->(l) SET r.role = m[2];

// ---- SIDED_WITH -----------------------------------------------------------
UNWIND [
  ['macer-varren','loyalist'],['corswain','loyalist'],['torghun-khan','loyalist'],
  ['bjorn','loyalist'],['alexis-polux','loyalist'],['fafnir-rann','loyalist'],
  ['amit','loyalist'],['zephon','loyalist'],['autek-mor','loyalist'],
  ['aeonid-thiel','loyalist'],['tylos-rubio','loyalist'],['nykona-sharrowkyn','loyalist'],
  ['maloghurst','traitor'],['serghar-targost','traitor'],['falkus-kibre','traitor'],
  ['tybalt-marr','traitor'],['kalus-ekaddon','traitor'],['marius-vairosean','traitor'],
  ['ignatius-grulgor','traitor'],['zardu-layak','traitor'],['hol-beloth','traitor'],
  ['hathor-maat','traitor'],['menkaura','traitor'],['forrix','traitor'],
  ['zso-sahaal','traitor'],['ingo-pech','traitor']
] AS s
MATCH (c {id: s[0]}), (a {id: s[1]})
MERGE (c)-[:SIDED_WITH]->(a);

// ---- DEVOTED_TO {degree} --------------------------------------------------
UNWIND [
  ['marius-vairosean','slaanesh','influenced'],
  ['zardu-layak','chaos-undivided','sworn'],
  ['hathor-maat','tzeentch','influenced'],
  ['menkaura','tzeentch','influenced']
] AS d
MATCH (c {id: d[0]}), (g {id: d[1]})
MERGE (c)-[r:DEVOTED_TO]->(g) SET r.degree = d[2];

// ---- PARTICIPATED_IN {side, role} -----------------------------------------
UNWIND [
  ['maloghurst','siege-of-terra','traitor','Equerry'],
  ['falkus-kibre','boarding-vengeful-spirit','traitor','Justaerin'],
  ['kalus-ekaddon','boarding-vengeful-spirit','traitor','Boarding assault'],
  ['tybalt-marr','siege-of-terra','traitor','Captain'],
  ['serghar-targost','isstvan-iii','traitor','Lodge Master'],
  ['marius-vairosean','isstvan-iii','traitor','Kakophoni'],
  ['ignatius-grulgor','isstvan-iii','traitor','Fell on the Eisenstein'],
  ['macer-varren','isstvan-iii','loyalist','Survivor'],
  ['zardu-layak','siege-of-terra','traitor','Crimson Apostle'],
  ['hol-beloth','battle-of-calth','traitor','Commander'],
  ['hathor-maat','burning-of-prospero','traitor','Defender of Prospero'],
  ['menkaura','burning-of-prospero','traitor','Seer'],
  ['bjorn','burning-of-prospero','loyalist','War-walker'],
  ['forrix','battle-of-phall','traitor','Triarch'],
  ['forrix','siege-of-terra','traitor','Triarch'],
  ['alexis-polux','battle-of-phall','loyalist','Commander'],
  ['fafnir-rann','siege-of-terra','loyalist','Huscarl'],
  ['corswain','thramas-crusade','loyalist','Seneschal'],
  ['zso-sahaal','thramas-crusade','traitor','Talonmaster'],
  ['torghun-khan','siege-of-terra','loyalist','Khan'],
  ['ingo-pech','isstvan-v','traitor','First Captain'],
  ['autek-mor','isstvan-v','loyalist','Survivor'],
  ['nykona-sharrowkyn','isstvan-v','loyalist','Survivor'],
  ['aeonid-thiel','battle-of-calth','loyalist','Sergeant'],
  ['tylos-rubio','battle-of-calth','loyalist','Librarian'],
  ['amit','signus-campaign','loyalist','Captain'],
  ['amit','siege-of-terra','loyalist','Captain'],
  ['zephon','signus-campaign','loyalist','Sanguinary Guard']
] AS p
MATCH (c {id: p[0]}), (e {id: p[1]})
MERGE (c)-[r:PARTICIPATED_IN]->(e) SET r.side = p[2], r.role = p[3];

// ---- Bonds: ALLY_OF / MENTOR_OF / RIVAL_OF --------------------------------
UNWIND [
  ['maloghurst','horus-lupercal'],['macer-varren','nathaniel-garro'],
  ['tylos-rubio','nathaniel-garro'],['forrix','perturabo'],
  ['bjorn','leman-russ'],['aeonid-thiel','roboute-guilliman']
] AS r
MATCH (a {id: r[0]}), (b {id: r[1]})
MERGE (a)-[:ALLY_OF]->(b);

UNWIND [
  ['lion-eljonson','corswain'],['konrad-curze','zso-sahaal']
] AS r
MATCH (a {id: r[0]}), (b {id: r[1]})
MERGE (a)-[:MENTOR_OF]->(b);
