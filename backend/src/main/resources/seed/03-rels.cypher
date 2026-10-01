// ============================================================================
// RELATIONSHIPS — match both endpoints by unique slug `id`, then MERGE the
// single relationship (never a whole path). Idempotent.
// ============================================================================

// ---- SON_OF : primarch -> emperor -----------------------------------------
MATCH (e {id: 'the-emperor'})
MATCH (p:Primarch) WHERE p.id IN [
  'lion-eljonson','fulgrim','perturabo','jaghatai-khan','leman-russ','rogal-dorn',
  'konrad-curze','sanguinius','ferrus-manus','angron','roboute-guilliman','mortarion',
  'magnus-the-red','horus-lupercal','lorgar','vulkan','corvus-corax','alpharius']
MERGE (p)-[:SON_OF]->(e);

// ---- PRIMARCH_OF : primarch -> legion --------------------------------------
UNWIND [
  ['lion-eljonson','dark-angels'],['fulgrim','emperors-children'],['perturabo','iron-warriors'],
  ['jaghatai-khan','white-scars'],['leman-russ','space-wolves'],['rogal-dorn','imperial-fists'],
  ['konrad-curze','night-lords'],['sanguinius','blood-angels'],['ferrus-manus','iron-hands'],
  ['angron','world-eaters'],['roboute-guilliman','ultramarines'],['mortarion','death-guard'],
  ['magnus-the-red','thousand-sons'],['horus-lupercal','sons-of-horus'],['lorgar','word-bearers'],
  ['vulkan','salamanders'],['corvus-corax','raven-guard'],['alpharius','alpha-legion']
] AS pair
MATCH (p {id: pair[0]}), (l {id: pair[1]})
MERGE (p)-[:PRIMARCH_OF]->(l);

// ---- MEMBER_OF {role} : astartes/dreadnought -> legion ---------------------
UNWIND [
  ['garviel-loken','sons-of-horus','Captain, 10th Company'],
  ['ezekyle-abaddon','sons-of-horus','First Captain'],
  ['tarik-torgaddon','sons-of-horus','Captain, Mournival'],
  ['horus-aximand','sons-of-horus','Captain, Mournival'],
  ['iacton-qruze','sons-of-horus','Veteran Commander'],
  ['saul-tarvitz','emperors-children','Captain'],
  ['lucius','emperors-children','Swordsman'],
  ['eidolon','emperors-children','Lord Commander'],
  ['fabius','emperors-children','Chief Apothecary'],
  ['nathaniel-garro','death-guard','Battle-Captain'],
  ['calas-typhon','death-guard','First Captain'],
  ['kharn','world-eaters','Equerry, 8th Captain'],
  ['erebus','word-bearers','Dark Apostle'],
  ['kor-phaeron','word-bearers','First Captain'],
  ['argel-tal','word-bearers','Gal Vorbak'],
  ['ahzek-ahriman','thousand-sons','Chief Librarian'],
  ['sigismund','imperial-fists','First Captain'],
  ['raldoron','blood-angels','Chapter Master'],
  ['azkaellon','blood-angels','Sanguinary Guard Commander'],
  ['remus-ventanus','ultramarines','Captain'],
  ['artellus-numeon','salamanders','Equerry'],
  ['shadrak-meduson','iron-hands','Warleader'],
  ['barabas-dantioch','iron-warriors','Warsmith'],
  ['jago-sevatarion','night-lords','First Captain'],
  ['shiban-khan','white-scars','Khan'],
  ['ancient-rylanor','emperors-children','Ancient'],
  ['cassian-dracos','iron-hands','Contemptor Dreadnought'],
  ['telemechrus','ultramarines','Dreadnought']
] AS m
MATCH (c {id: m[0]}), (l {id: m[1]})
MERGE (c)-[r:MEMBER_OF]->(l) SET r.role = m[2];

// ---- SIDED_WITH : legions -> allegiance ------------------------------------
UNWIND [
  ['dark-angels','loyalist'],['white-scars','loyalist'],['space-wolves','loyalist'],
  ['imperial-fists','loyalist'],['blood-angels','loyalist'],['iron-hands','loyalist'],
  ['ultramarines','loyalist'],['salamanders','loyalist'],['raven-guard','loyalist'],
  ['emperors-children','traitor'],['iron-warriors','traitor'],['night-lords','traitor'],
  ['world-eaters','traitor'],['death-guard','traitor'],['thousand-sons','traitor'],
  ['sons-of-horus','traitor'],['word-bearers','traitor'],['alpha-legion','traitor']
] AS s
MATCH (l {id: s[0]}), (a {id: s[1]})
MERGE (l)-[:SIDED_WITH]->(a);

// ---- SIDED_WITH : characters -> allegiance ---------------------------------
// The Emperor and all loyalists (incl. loyalists inside traitor Legions).
UNWIND [
  ['the-emperor','loyalist'],
  ['lion-eljonson','loyalist'],['jaghatai-khan','loyalist'],['leman-russ','loyalist'],
  ['rogal-dorn','loyalist'],['sanguinius','loyalist'],['ferrus-manus','loyalist'],
  ['roboute-guilliman','loyalist'],['vulkan','loyalist'],['corvus-corax','loyalist'],
  ['fulgrim','traitor'],['perturabo','traitor'],['konrad-curze','traitor'],
  ['angron','traitor'],['mortarion','traitor'],['magnus-the-red','traitor'],
  ['horus-lupercal','traitor'],['lorgar','traitor'],['alpharius','traitor'],
  ['garviel-loken','loyalist'],['tarik-torgaddon','loyalist'],['iacton-qruze','loyalist'],
  ['saul-tarvitz','loyalist'],['nathaniel-garro','loyalist'],['sigismund','loyalist'],
  ['raldoron','loyalist'],['azkaellon','loyalist'],['remus-ventanus','loyalist'],
  ['artellus-numeon','loyalist'],['shadrak-meduson','loyalist'],['barabas-dantioch','loyalist'],
  ['shiban-khan','loyalist'],['ancient-rylanor','loyalist'],['cassian-dracos','loyalist'],
  ['telemechrus','loyalist'],
  ['ezekyle-abaddon','traitor'],['horus-aximand','traitor'],['lucius','traitor'],
  ['eidolon','traitor'],['fabius','traitor'],['calas-typhon','traitor'],['kharn','traitor'],
  ['erebus','traitor'],['kor-phaeron','traitor'],['argel-tal','traitor'],
  ['ahzek-ahriman','traitor'],['jago-sevatarion','traitor']
] AS s
MATCH (c {id: s[0]}), (a {id: s[1]})
MERGE (c)-[:SIDED_WITH]->(a);

// ---- DEVOTED_TO {degree} : character/legion -> chaos god --------------------
UNWIND [
  ['angron','khorne','sworn'],['world-eaters','khorne','sworn'],['kharn','khorne','sworn'],
  ['mortarion','nurgle','sworn'],['death-guard','nurgle','sworn'],['calas-typhon','nurgle','sworn'],
  ['magnus-the-red','tzeentch','sworn'],['thousand-sons','tzeentch','influenced'],
  ['ahzek-ahriman','tzeentch','influenced'],
  ['fulgrim','slaanesh','sworn'],['emperors-children','slaanesh','sworn'],
  ['lucius','slaanesh','sworn'],['eidolon','slaanesh','influenced'],['fabius','slaanesh','influenced'],
  ['lorgar','chaos-undivided','sworn'],['word-bearers','chaos-undivided','sworn'],
  ['erebus','chaos-undivided','sworn'],['kor-phaeron','chaos-undivided','sworn'],
  ['argel-tal','chaos-undivided','sworn'],['horus-lupercal','chaos-undivided','sworn']
] AS d
MATCH (c {id: d[0]}), (g {id: d[1]})
MERGE (c)-[r:DEVOTED_TO]->(g) SET r.degree = d[2];

// ---- FOUGHT_IN {side} : legion -> event ------------------------------------
UNWIND [
  ['sons-of-horus','triumph-at-ullanor','imperial'],
  ['word-bearers','censure-at-monarchia','imperial'],
  ['thousand-sons','council-of-nikaea','imperial'],
  ['space-wolves','council-of-nikaea','imperial'],
  ['sons-of-horus','isstvan-iii','traitor'],['emperors-children','isstvan-iii','traitor'],
  ['world-eaters','isstvan-iii','traitor'],['death-guard','isstvan-iii','traitor'],
  ['iron-hands','isstvan-v','loyalist'],['salamanders','isstvan-v','loyalist'],
  ['raven-guard','isstvan-v','loyalist'],['sons-of-horus','isstvan-v','traitor'],
  ['emperors-children','isstvan-v','traitor'],['iron-warriors','isstvan-v','traitor'],
  ['night-lords','isstvan-v','traitor'],['word-bearers','isstvan-v','traitor'],
  ['alpha-legion','isstvan-v','traitor'],['world-eaters','isstvan-v','traitor'],
  ['death-guard','isstvan-v','traitor'],
  ['space-wolves','burning-of-prospero','loyalist'],['thousand-sons','burning-of-prospero','traitor'],
  ['word-bearers','battle-of-calth','traitor'],['ultramarines','battle-of-calth','loyalist'],
  ['blood-angels','signus-campaign','loyalist'],
  ['iron-warriors','battle-of-phall','traitor'],['imperial-fists','battle-of-phall','loyalist'],
  ['dark-angels','thramas-crusade','loyalist'],['night-lords','thramas-crusade','traitor'],
  ['imperial-fists','siege-of-terra','loyalist'],['blood-angels','siege-of-terra','loyalist'],
  ['white-scars','siege-of-terra','loyalist'],['sons-of-horus','siege-of-terra','traitor'],
  ['world-eaters','siege-of-terra','traitor'],['death-guard','siege-of-terra','traitor'],
  ['emperors-children','siege-of-terra','traitor'],['iron-warriors','siege-of-terra','traitor'],
  ['word-bearers','siege-of-terra','traitor'],['alpha-legion','siege-of-terra','traitor'],
  ['thousand-sons','siege-of-terra','traitor'],['night-lords','siege-of-terra','traitor'],
  ['sons-of-horus','boarding-vengeful-spirit','traitor']
] AS f
MATCH (l {id: f[0]}), (e {id: f[1]})
MERGE (l)-[r:FOUGHT_IN]->(e) SET r.side = f[2];

// ---- PARTICIPATED_IN {side, role, presence} : character -> event -----------
// presence ∈ physical|supporting|strategic|psychic|vision|aftermath|reinforcement.
// Direct physical participation is NOT the same as directing a battle from afar.
UNWIND [
  ['the-emperor','triumph-at-ullanor','imperial','Named the Warmaster','physical'],
  ['the-emperor','censure-at-monarchia','imperial','Rebuked Lorgar','physical'],
  ['the-emperor','council-of-nikaea','imperial','Judge','physical'],
  ['the-emperor','boarding-vengeful-spirit','loyalist','Slew Horus','physical'],
  ['horus-lupercal','triumph-at-ullanor','imperial','Honoured as Warmaster','physical'],
  ['horus-lupercal','davin','traitor','Wounded and turned','physical'],
  ['horus-lupercal','isstvan-iii','traitor','Warmaster','physical'],
  ['horus-lupercal','siege-of-terra','traitor','Warmaster','physical'],
  ['horus-lupercal','boarding-vengeful-spirit','traitor','Slain by the Emperor','physical'],
  ['erebus','davin','traitor','Architect of the fall','physical'],
  ['lorgar','censure-at-monarchia','imperial','Humiliated','physical'],
  ['lorgar','battle-of-calth','traitor','Commander','physical'],
  ['angron','battle-of-calth','traitor','Shadow Crusade','supporting'],
  ['kor-phaeron','battle-of-calth','traitor','Commander','physical'],
  ['remus-ventanus','battle-of-calth','loyalist','Defender','physical'],
  ['telemechrus','battle-of-calth','loyalist','Newly interred','physical'],
  ['magnus-the-red','council-of-nikaea','imperial','Defendant','physical'],
  ['magnus-the-red','burning-of-prospero','traitor','Defender of Prospero','physical'],
  ['leman-russ','burning-of-prospero','loyalist','Executioner of the censure','physical'],
  ['garviel-loken','isstvan-iii','loyalist','Left for dead','physical'],
  ['tarik-torgaddon','isstvan-iii','loyalist','Slain','physical'],
  ['horus-aximand','isstvan-iii','traitor','Slew Torgaddon','physical'],
  ['saul-tarvitz','isstvan-iii','loyalist','Warned the loyal','physical'],
  ['ancient-rylanor','isstvan-iii','loyalist','Self-sacrifice','physical'],
  ['ferrus-manus','isstvan-v','loyalist','Slain','physical'],
  ['fulgrim','isstvan-v','traitor','Slew Ferrus Manus','physical'],
  ['vulkan','isstvan-v','loyalist','Survivor','physical'],
  ['corvus-corax','isstvan-v','loyalist','Survivor','physical'],
  ['shadrak-meduson','isstvan-v','loyalist','Survivor','physical'],
  ['sanguinius','signus-campaign','loyalist','Ensnared','physical'],
  ['azkaellon','signus-campaign','loyalist','Sanguinary Guard','physical'],
  ['raldoron','signus-campaign','loyalist','Chapter Master','physical'],
  ['perturabo','battle-of-phall','traitor','Commander','physical'],
  // §15: Dorn issued the retribution order but was not physically at Phall.
  ['rogal-dorn','battle-of-phall','loyalist','Ordered the Retribution Fleet','strategic'],
  ['lion-eljonson','thramas-crusade','loyalist','Commander','physical'],
  ['konrad-curze','thramas-crusade','traitor','Commander','physical'],
  ['jago-sevatarion','thramas-crusade','traitor','First Captain','physical'],
  ['rogal-dorn','siege-of-terra','loyalist','Praetorian of Terra','physical'],
  ['sigismund','siege-of-terra','loyalist','Champion','physical'],
  ['jaghatai-khan','siege-of-terra','loyalist','Defender','physical'],
  ['sanguinius','siege-of-terra','loyalist','Defender','physical'],
  ['ezekyle-abaddon','siege-of-terra','traitor','First Captain','physical'],
  ['sanguinius','boarding-vengeful-spirit','loyalist','Slain by Horus','physical']
] AS p
MATCH (c {id: p[0]}), (e {id: p[1]})
MERGE (c)-[r:PARTICIPATED_IN]->(e) SET r.side = p[2], r.role = p[3], r.presence = p[4];

// ---- KILLED {event} : character -> character -------------------------------
UNWIND [
  ['fulgrim','ferrus-manus','Isstvan V'],
  ['horus-aximand','tarik-torgaddon','Isstvan III'],
  ['horus-lupercal','sanguinius','Siege of Terra'],
  ['the-emperor','horus-lupercal','Boarding of the Vengeful Spirit'],
  ['kharn','argel-tal','Shadow Crusade']
] AS k
MATCH (a {id: k[0]}), (b {id: k[1]})
MERGE (a)-[r:KILLED]->(b) SET r.event = k[2];

// ---- RIVAL_OF / ALLY_OF / MENTOR_OF ----------------------------------------
UNWIND [
  ['perturabo','rogal-dorn'],['leman-russ','magnus-the-red'],
  ['konrad-curze','rogal-dorn'],['lion-eljonson','leman-russ'],
  ['lucius','saul-tarvitz']
] AS r
MATCH (a {id: r[0]}), (b {id: r[1]})
MERGE (a)-[:RIVAL_OF]->(b);

UNWIND [
  ['fulgrim','ferrus-manus'],['sanguinius','rogal-dorn']
] AS r
MATCH (a {id: r[0]}), (b {id: r[1]})
MERGE (a)-[:ALLY_OF]->(b);

UNWIND [
  ['horus-lupercal','garviel-loken'],['kor-phaeron','lorgar'],
  ['rogal-dorn','sigismund'],['erebus','argel-tal']
] AS r
MATCH (a {id: r[0]}), (b {id: r[1]})
MERGE (a)-[:MENTOR_OF]->(b);

// ---- PART_OF : event -> event ----------------------------------------------
// The Siege of Terra is an umbrella over its phase battles.
UNWIND [
  'solar-war','lions-gate','saturnine','eternity-gate','inner-palace','boarding-vengeful-spirit'
] AS phase
MATCH (a {id: phase}), (b {id: 'siege-of-terra'})
MERGE (a)-[:PART_OF]->(b);

// ---- Additional / corrected connections ------------------------------------
// The Censure at Monarchia: the Emperor had Guilliman's Ultramarines raze
// Lorgar's perfect city and made the Word Bearers kneel in its ashes.
MATCH (l {id: 'ultramarines'}), (e {id: 'censure-at-monarchia'})
MERGE (l)-[r:FOUGHT_IN]->(e) SET r.side = 'imperial';

// §15 correction: Guilliman commanded the Ullanor *Crusade* but did NOT attend
// the Triumph ceremony — any such edge is removed.
MATCH (:Character {id: 'roboute-guilliman'})-[r:PARTICIPATED_IN]->(:Event {id: 'triumph-at-ullanor'})
DELETE r;

UNWIND [
  ['roboute-guilliman','censure-at-monarchia','imperial','Razed Monarchia at the Emperor\'s command','physical'],
  ['roboute-guilliman','battle-of-calth','loyalist','Lord of Ultramar','physical'],
  // §13: Guilliman marched for Terra but arrived only after the Siege was decided.
  ['roboute-guilliman','siege-of-terra','loyalist','Marching to relieve Terra','reinforcement'],
  ['mortarion','isstvan-iii','traitor','Purged his own loyal sons','physical'],
  ['mortarion','siege-of-terra','traitor','Warlord of the Death Guard','physical'],
  ['angron','isstvan-iii','traitor','Led the red slaughter','physical'],
  ['alpharius','isstvan-v','traitor','Among the reserve that turned','physical']
] AS p
MATCH (c {id: p[0]}), (e {id: p[1]})
MERGE (c)-[r:PARTICIPATED_IN]->(e) SET r.side = p[2], r.role = p[3], r.presence = p[4];

// The humiliation at Monarchia set Lorgar against Guilliman for all time — a
// hatred that later fell upon Ultramar at Calth.
MATCH (a {id: 'lorgar'}), (b {id: 'roboute-guilliman'})
MERGE (a)-[:RIVAL_OF]->(b);
