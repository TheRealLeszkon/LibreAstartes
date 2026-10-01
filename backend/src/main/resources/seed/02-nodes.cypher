// ============================================================================
// NODES — idempotent MERGE on `id`, then SET all properties.
// Lore text is original high-level summary. Contested points go in `loreNote`.
// ============================================================================

// ---- Allegiance -----------------------------------------------------------
MERGE (n:Allegiance {id: 'loyalist'})
  SET n.name = 'Loyalist', n.subtitle = 'Oath to the Emperor',
      n.description = 'Those who held to their oaths to the Emperor of Mankind when Horus turned against Terra.';
MERGE (n:Allegiance {id: 'traitor'})
  SET n.name = 'Traitor', n.subtitle = 'Sworn to the Warmaster',
      n.description = 'Those who followed Horus into rebellion, many of them falling under the sway of the Ruinous Powers.';

// ---- Emperor --------------------------------------------------------------
MERGE (n:Character:Emperor {id: 'the-emperor'})
  SET n.name = 'The Emperor of Mankind', n.subtitle = 'Master of the Imperium',
      n.description = 'The immortal architect of the Imperium and father of the primarchs. He launched the Great Crusade to reunite the scattered worlds of humanity and withdrew to Terra to pursue a secret work beneath the palace. His absence and silence left room for resentment to fester among his sons.',
      n.motivations = 'To secure the future of humanity and shepherd it into a rational, unified age free of gods and daemons.',
      n.fate = 'Mortally wounded aboard the Vengeful Spirit while slaying Horus; interred upon the Golden Throne.';

// ---- Legions --------------------------------------------------------------
// I Dark Angels
MERGE (n:Legion {id: 'dark-angels'})
  SET n.name = 'Dark Angels', n.numeral = 'I', n.subtitle = 'The First Legion',
      n.homeworld = 'Caliban', n.primaryColor = '#0b1a14', n.secondaryColor = '#c8c0a8',
      n.description = 'The First Legion, knightly and secretive, raised on the forest-world of Caliban.',
      n.loreNote = 'The schism between Lion El\'Jonson and Luther on Caliban sowed seeds that would echo for ten thousand years.';
// II Expunged
MERGE (n:Legion {id: 'legion-ii'})
  SET n.name = 'Records Expunged', n.numeral = 'II', n.subtitle = 'Records Expunged',
      n.expunged = true, n.primaryColor = '#2a2a2a', n.secondaryColor = '#1a1a1a',
      n.description = 'All record of the Second Legion and its primarch has been struck from Imperial archives.',
      n.loreNote = 'The fate of the two lost Legions and their primarchs is deliberately unrecorded in canon.';
// III Emperor's Children
MERGE (n:Legion {id: 'emperors-children'})
  SET n.name = 'Emperor\'s Children', n.numeral = 'III', n.subtitle = 'The Phoenician\'s pride',
      n.homeworld = 'Chemos', n.primaryColor = '#5b2a83', n.secondaryColor = '#d4af37',
      n.description = 'A Legion obsessed with perfection, granted the honour of bearing the Emperor\'s own palatine aquila.',
      n.loreNote = 'Their pursuit of perfection curdled into the excess of Slaanesh during the Heresy.';
// IV Iron Warriors
MERGE (n:Legion {id: 'iron-warriors'})
  SET n.name = 'Iron Warriors', n.numeral = 'IV', n.subtitle = 'Masters of the siege',
      n.homeworld = 'Olympia', n.primaryColor = '#4a4a4a', n.secondaryColor = '#c0a020',
      n.description = 'Grim siege-breakers who bore the hardest, most thankless labours of the Great Crusade.';
// V White Scars
MERGE (n:Legion {id: 'white-scars'})
  SET n.name = 'White Scars', n.numeral = 'V', n.subtitle = 'The lightning riders',
      n.homeworld = 'Chogoris', n.primaryColor = '#e8e8e8', n.secondaryColor = '#8a1b1b',
      n.description = 'Swift horsemen of Chogoris who struck like lightning and vanished before the counterblow.';
// VI Space Wolves
MERGE (n:Legion {id: 'space-wolves'})
  SET n.name = 'Space Wolves', n.numeral = 'VI', n.subtitle = 'The Emperor\'s executioners',
      n.homeworld = 'Fenris', n.primaryColor = '#8a97a0', n.secondaryColor = '#d9b45b',
      n.description = 'The feral sons of Fenris, kept as the Emperor\'s blade of last resort against his own errant Legions.';
// VII Imperial Fists
MERGE (n:Legion {id: 'imperial-fists'})
  SET n.name = 'Imperial Fists', n.numeral = 'VII', n.subtitle = 'The Praetorians of Terra',
      n.homeworld = 'Terra (Inwit)', n.primaryColor = '#d9a520', n.secondaryColor = '#1a1a1a',
      n.description = 'Unyielding defenders entrusted with the fortification of the Imperial Palace itself.';
// VIII Night Lords
MERGE (n:Legion {id: 'night-lords'})
  SET n.name = 'Night Lords', n.numeral = 'VIII', n.subtitle = 'Terror as a weapon',
      n.homeworld = 'Nostramo', n.primaryColor = '#26303f', n.secondaryColor = '#c8d0d8',
      n.description = 'Wielders of fear and atrocity, who policed the Imperium through dread.',
      n.loreNote = 'The Night Lords are debated as rebels more than true devotees of Chaos; their terror was its own creed.';
// IX Blood Angels
MERGE (n:Legion {id: 'blood-angels'})
  SET n.name = 'Blood Angels', n.numeral = 'IX', n.subtitle = 'The angelic host',
      n.homeworld = 'Baal', n.primaryColor = '#8f1515', n.secondaryColor = '#d4af37',
      n.description = 'Noble and beautiful warriors led by the winged Sanguinius, hiding a secret curse in their blood.';
// X Iron Hands
MERGE (n:Legion {id: 'iron-hands'})
  SET n.name = 'Iron Hands', n.numeral = 'X', n.subtitle = 'The flesh is weak',
      n.homeworld = 'Medusa', n.primaryColor = '#16181a', n.secondaryColor = '#6a6f75',
      n.description = 'Severe warriors of Medusa who distrust frailty and replace flesh with iron.';
// XI Expunged
MERGE (n:Legion {id: 'legion-xi'})
  SET n.name = 'Records Expunged', n.numeral = 'XI', n.subtitle = 'Records Expunged',
      n.expunged = true, n.primaryColor = '#2a2a2a', n.secondaryColor = '#1a1a1a',
      n.description = 'All record of the Eleventh Legion and its primarch has been struck from Imperial archives.',
      n.loreNote = 'The fate of the two lost Legions and their primarchs is deliberately unrecorded in canon.';
// XII World Eaters
MERGE (n:Legion {id: 'world-eaters'})
  SET n.name = 'World Eaters', n.numeral = 'XII', n.subtitle = 'The red slaughter',
      n.homeworld = 'Nuceria', n.primaryColor = '#dfe3e6', n.secondaryColor = '#15396b',
      n.description = 'Once the War Hounds, remade into frenzied butchers by the Butcher\'s Nails implanted in their skulls.';
// XIII Ultramarines
MERGE (n:Legion {id: 'ultramarines'})
  SET n.name = 'Ultramarines', n.numeral = 'XIII', n.subtitle = 'The sons of Ultramar',
      n.homeworld = 'Macragge', n.primaryColor = '#11407a', n.secondaryColor = '#d4af37',
      n.description = 'The largest Legion, builders and administrators as much as warriors, rulers of the realm of Ultramar.';
// XIV Death Guard
MERGE (n:Legion {id: 'death-guard'})
  SET n.name = 'Death Guard', n.numeral = 'XIV', n.subtitle = 'The implacable',
      n.homeworld = 'Barbarus', n.primaryColor = '#cfd2c4', n.secondaryColor = '#3f6f3f',
      n.description = 'Stoic and all but unkillable, they endured poisons and plagues that would fell any other warrior.';
// XV Thousand Sons
MERGE (n:Legion {id: 'thousand-sons'})
  SET n.name = 'Thousand Sons', n.numeral = 'XV', n.subtitle = 'Masters of the warp',
      n.homeworld = 'Prospero', n.primaryColor = '#a01818', n.secondaryColor = '#d4af37',
      n.description = 'Scholars and sorcerers whose mastery of psychic arts set them at odds with the edicts of Nikaea.',
      n.loreNote = 'Whether the Thousand Sons were truly traitors or victims of Prospero\'s burning is fiercely contested.';
// XVI Sons of Horus
MERGE (n:Legion {id: 'sons-of-horus'})
  SET n.name = 'Sons of Horus', n.numeral = 'XVI', n.subtitle = 'The Warmaster\'s own',
      n.homeworld = 'Cthonia', n.primaryColor = '#2f5d50', n.secondaryColor = '#1a1a1a',
      n.description = 'Formerly the Luna Wolves, renamed to honour Horus and foremost among the Legions until his fall.';
// XVII Word Bearers
MERGE (n:Legion {id: 'word-bearers'})
  SET n.name = 'Word Bearers', n.numeral = 'XVII', n.subtitle = 'The bearers of the word',
      n.homeworld = 'Colchis', n.primaryColor = '#6e1414', n.secondaryColor = '#3a3a3a',
      n.description = 'Zealots who worshipped first the Emperor as a god and then, spurned, the dark gods of the warp.';
// XVIII Salamanders
MERGE (n:Legion {id: 'salamanders'})
  SET n.name = 'Salamanders', n.numeral = 'XVIII', n.subtitle = 'The sons of fire',
      n.homeworld = 'Nocturne', n.primaryColor = '#1b5e3a', n.secondaryColor = '#1a1a1a',
      n.description = 'Artisan-warriors of the volcanic world Nocturne, known for compassion rare among the Legions.';
// XIX Raven Guard
MERGE (n:Legion {id: 'raven-guard'})
  SET n.name = 'Raven Guard', n.numeral = 'XIX', n.subtitle = 'Victory through guile',
      n.homeworld = 'Deliverance', n.primaryColor = '#15171a', n.secondaryColor = '#c8c0a8',
      n.description = 'Masters of stealth and lightning raids, liberators who prized freedom above all.';
// XX Alpha Legion
MERGE (n:Legion {id: 'alpha-legion'})
  SET n.name = 'Alpha Legion', n.numeral = 'XX', n.subtitle = 'For the Emperor',
      n.homeworld = 'Unknown', n.primaryColor = '#1f5f6b', n.secondaryColor = '#3a4a55',
      n.description = 'The last and most secretive Legion, masters of infiltration, misdirection and the long game.',
      n.loreNote = 'Alpha Legion motives remain the setting\'s greatest enigma: some claim they served a hidden loyalist purpose to the very end.';

// ---- Primarchs ------------------------------------------------------------
MERGE (n:Character:Primarch {id: 'lion-eljonson'})
  SET n.name = 'Lion El\'Jonson', n.subtitle = 'Primarch of the Dark Angels',
      n.description = 'Found alone in the deadly forests of Caliban, the Lion became a peerless knight and strategist. Aloof and secretive, he kept his own counsel even from his brothers. His manoeuvres during the Heresy were widely mistrusted despite his loyalty.',
      n.motivations = 'Order, duty, and the keeping of secrets he believed too dangerous to share.',
      n.fate = 'Struck down by his fallen friend Luther and lost to legend.',
      n.image = 'assets/lion-eljonson.jpg';
MERGE (n:Character:Primarch {id: 'fulgrim'})
  SET n.name = 'Fulgrim', n.subtitle = 'Primarch of the Emperor\'s Children',
      n.description = 'The Phoenician raised Chemos from starvation and pursued perfection in all things. His quest for excellence became vanity, and vanity became the doorway to Slaanesh. He was among the first and most eagerly corrupted of the traitors.',
      n.motivations = 'Flawless perfection of body, mind and art — pursued without limit.',
      n.fate = 'Possessed and ultimately ascended as a daemon prince of Slaanesh.',
      n.image = 'assets/fulgrim.jpg';
MERGE (n:Character:Primarch {id: 'perturabo'})
  SET n.name = 'Perturabo', n.subtitle = 'Primarch of the Iron Warriors',
      n.description = 'A brilliant, bitter engineer who felt his Legion was used as siege-fodder and never thanked. His resentment of the Emperor and his rival Dorn drove him to rebellion. He is counted among the greatest military minds of the age.',
      n.motivations = 'Recognition, and the perfection of the science of destruction.',
      n.fate = 'Ascended to daemon prince-hood in service to Chaos.',
      n.image = 'assets/perturabo.jpg';
MERGE (n:Character:Primarch {id: 'jaghatai-khan'})
  SET n.name = 'Jaghatai Khan', n.subtitle = 'Primarch of the White Scars',
      n.description = 'The Warhawk of Chogoris united its warring tribes before the Emperor came. He prized freedom and speed, and hesitated between the sides until he judged the truth for himself. He chose loyalty and rode to the defence of Terra.',
      n.motivations = 'Freedom, swiftness, and the right to choose his own road.',
      n.image = 'assets/jaghatai-khan.jpg';
MERGE (n:Character:Primarch {id: 'leman-russ'})
  SET n.name = 'Leman Russ', n.subtitle = 'Primarch of the Space Wolves',
      n.description = 'The Wolf King of Fenris, the Emperor\'s blunt instrument of censure. He carried out the burning of Prospero on the Emperor\'s command, a deed that haunted the Legions. Fierce and loyal, he remained the Emperor\'s executioner.',
      n.motivations = 'Loyalty to the Emperor and the honour of the hunt.',
      n.image = 'assets/leman-russ.jpg';
MERGE (n:Character:Primarch {id: 'rogal-dorn'})
  SET n.name = 'Rogal Dorn', n.subtitle = 'Primarch of the Imperial Fists',
      n.description = 'The Praetorian of Terra, charged with the defence of the Imperial Palace. Stern, honest and unbreakable, he raised the greatest fortifications in human history. He bore the weight of the Siege of Terra upon his shoulders.',
      n.motivations = 'Duty, honesty, and the unyielding defence of the Emperor.',
      n.image = 'assets/rogal-dorn.jpg';
MERGE (n:Character:Primarch {id: 'konrad-curze'})
  SET n.name = 'Konrad Curze', n.subtitle = 'Primarch of the Night Lords',
      n.description = 'The Night Haunter grew up alone in the crime-ridden dark of Nostramo, ruling it through terror. Plagued by visions of his own death, he came to believe his violence was fated and just. He turned his methods against the Imperium that condemned them.',
      n.motivations = 'A bleak, fatalistic justice enforced through fear.',
      n.fate = 'Allowed an Imperial assassin to kill him, to prove his guilt and the hypocrisy of his judges.',
      n.loreNote = 'Curze\'s link to Chaos is thin; his cruelty was conviction, not worship.',
      n.image = 'assets/konrad-curze.jpg';
MERGE (n:Character:Primarch {id: 'sanguinius'})
  SET n.name = 'Sanguinius', n.subtitle = 'Primarch of the Blood Angels',
      n.description = 'The winged angel of Baal, beloved by his brothers and the Emperor alike. Noble, wise and doomed, he foresaw his own death yet did not flinch from it. He fell defending Terra so that the Emperor might prevail.',
      n.motivations = 'To shield humanity and hold the line though it cost him everything.',
      n.fate = 'Slain by Horus aboard the Vengeful Spirit during the Siege of Terra.',
      n.image = 'assets/sanguinius.jpg';
MERGE (n:Character:Primarch {id: 'ferrus-manus'})
  SET n.name = 'Ferrus Manus', n.subtitle = 'Primarch of the Iron Hands',
      n.description = 'The Gorgon of Medusa, his hands fused to living silver metal. Uncompromising and headstrong, he despised weakness in any form. His rashness at the Dropsite Massacre cost him his life.',
      n.motivations = 'Strength, iron resolve, and the conquest of frailty.',
      n.fate = 'Beheaded by his former friend Fulgrim at Isstvan V.',
      n.image = 'assets/ferrus-manus.jpg';
MERGE (n:Character:Primarch {id: 'angron'})
  SET n.name = 'Angron', n.subtitle = 'Primarch of the World Eaters',
      n.description = 'Sold into slavery and the gladiator pits, Angron was scarred body and mind by the Butcher\'s Nails. The Emperor took him from a doomed last stand he would rather have died in. His rage made him the perfect vessel for Khorne.',
      n.motivations = 'Pain, fury, and a hatred of all chains — including those of his own making.',
      n.fate = 'Ascended as a daemon prince of Khorne.',
      n.image = 'assets/angron.jpg';
MERGE (n:Character:Primarch {id: 'roboute-guilliman'})
  SET n.name = 'Roboute Guilliman', n.subtitle = 'Primarch of the Ultramarines',
      n.description = 'The statesman-primarch of Macragge, builder of the realm of Ultramar. He saw the Imperium as a civilisation to be governed well, not merely conquered. When the Heresy came he laboured to hold the shattered Imperium together.',
      n.motivations = 'Good governance, order, and the survival of a civilised Imperium.',
      n.image = 'assets/roboute-guilliman.jpg';
MERGE (n:Character:Primarch {id: 'mortarion'})
  SET n.name = 'Mortarion', n.subtitle = 'Primarch of the Death Guard',
      n.description = 'Raised under the toxic skies of Barbarus by a cruel overlord, Mortarion clawed his way to strength through endurance of poison. He resented sorcery and the Emperor\'s secrets alike. His pride led him to a bargain with Nurgle he could not escape.',
      n.motivations = 'Self-reliance, endurance, and freedom from masters and sorcery.',
      n.fate = 'Became a daemon prince of Nurgle.',
      n.image = 'assets/mortarion.jpg';
MERGE (n:Character:Primarch {id: 'magnus-the-red'})
  SET n.name = 'Magnus the Red', n.subtitle = 'Primarch of the Thousand Sons',
      n.description = 'The cyclopean sorcerer-king of Prospero, greatest of psykers among the primarchs. Seeking to warn the Emperor of Horus\'s treachery, he shattered the wards of Terra with his sorcery. The disaster condemned his Legion and drove him into Tzeentch\'s grasp.',
      n.motivations = 'Knowledge, and the protection of his sons through forbidden means.',
      n.fate = 'Became a daemon prince of Tzeentch.',
      n.loreNote = 'Magnus\'s fall is tragic rather than wholly villainous; his gravest sin was pride in his own power.',
      n.image = 'assets/magnus-the-red.jpg';
MERGE (n:Character:Primarch {id: 'horus-lupercal'})
  SET n.name = 'Horus Lupercal', n.subtitle = 'The Warmaster',
      n.description = 'The first-found and best-loved of the primarchs, raised to Warmaster of all the Legions. Wounded on Davin and poisoned by doubt and the whispers of the Word Bearers, he turned against his father. His rebellion nearly ended the Imperium.',
      n.motivations = 'Once loyalty and glory; later the belief that the Emperor would become the very god he forbade.',
      n.fate = 'Slain by the Emperor aboard the Vengeful Spirit; his body and soul utterly unmade.',
      n.image = 'assets/horus-lupercal.jpg';
MERGE (n:Character:Primarch {id: 'lorgar'})
  SET n.name = 'Lorgar', n.subtitle = 'Primarch of the Word Bearers',
      n.description = 'The most devout of the primarchs, who worshipped the Emperor as a god until rebuked at Monarchia. Humiliated, he turned his unquenchable faith toward the powers of the warp. He was the true architect of the Heresy, seducing Horus into damnation.',
      n.motivations = 'To worship, and to be told that his worship has meaning.',
      n.fate = 'Ascended as a daemon prince of Chaos Undivided.',
      n.image = 'assets/lorgar.jpg';
MERGE (n:Character:Primarch {id: 'vulkan'})
  SET n.name = 'Vulkan', n.subtitle = 'Primarch of the Salamanders',
      n.description = 'The smith-king of Nocturne, a giant of great compassion and humanity. He survived the Dropsite Massacre that nearly annihilated his Legion. His resilience proved to be something more than mortal.',
      n.motivations = 'Compassion, craft, and the protection of ordinary people.',
      n.fate = 'Revealed to be a perpetual, able to return from death again and again.',
      n.image = 'assets/vulkan.jpg';
MERGE (n:Character:Primarch {id: 'corvus-corax'})
  SET n.name = 'Corvus Corax', n.subtitle = 'Primarch of the Raven Guard',
      n.description = 'The liberator of Deliverance, who overthrew a tyranny of chains before the Emperor found him. A master of stealth and insurgency, he fought to free rather than to rule. The Dropsite Massacre left his Legion all but destroyed.',
      n.motivations = 'Liberty, and the end of tyranny in all its forms.',
      n.fate = 'Exiled himself after a failed attempt to rebuild his Legion, departing into the void.',
      n.image = 'assets/corvus-corax.jpg';
MERGE (n:Character:Primarch {id: 'alpharius'})
  SET n.name = 'Alpharius', n.subtitle = 'Primarch of the Alpha Legion',
      n.description = 'The last primarch to be found, twin to the hidden Omegon. He wove his Legion into a web of agents, lies and contingencies. Whether he served Horus, Chaos, or a secret design of his own is never certain.',
      n.motivations = 'Known only to the Alpha Legion — and perhaps not even to all of them.',
      n.fate = 'Reportedly slain by Rogal Dorn, though with the Alpha Legion nothing is certain.',
      n.loreNote = 'Alpharius and Omegon are twin primarchs who often pose as one another; the Legion claims to serve a hidden loyalist cause.',
      n.image = 'assets/alpharius.jpg';

// ---- Astartes -------------------------------------------------------------
MERGE (n:Character:Astartes {id: 'garviel-loken'})
  SET n.name = 'Garviel Loken', n.subtitle = 'Captain, 10th Company',
      n.description = 'A principled captain of the Sons of Horus and member of the Mournival. He clung to honour and truth as his Legion fell into treachery. Left for dead on Isstvan III, he endured as a broken reminder of what the Legion had been.',
      n.fate = 'Survived the betrayal of Isstvan III and later fought on as a loyalist.',
      n.loreNote = 'Loken remained loyal within a traitor Legion, one of the Heresy\'s great tragic figures.';
MERGE (n:Character:Astartes {id: 'ezekyle-abaddon'})
  SET n.name = 'Ezekyle Abaddon', n.subtitle = 'First Captain of the Sons of Horus',
      n.description = 'Commander of the Justaerin and head of the Mournival, fiercely devoted to Horus. He embodied the pride and wrath of the Warmaster\'s chosen. He would long outlive the Heresy as a scourge of the Imperium.',
      n.fate = 'Survived the Heresy to become the Imperium\'s most feared enemy.';
MERGE (n:Character:Astartes {id: 'tarik-torgaddon'})
  SET n.name = 'Tarik Torgaddon', n.subtitle = 'Mournival, Sons of Horus',
      n.description = 'A towering, good-humoured captain of the Sons of Horus and a steadfast friend to Loken. His conscience would not bend to the Warmaster\'s treason.',
      n.fate = 'Murdered by his brother Horus Aximand during the virus-bombing of Isstvan III.';
MERGE (n:Character:Astartes {id: 'horus-aximand'})
  SET n.name = 'Horus Aximand', n.subtitle = 'Little Horus, Mournival',
      n.description = 'Called Little Horus for his resemblance to the Warmaster, a cold and capable captain. He chose the Legion over his friends, and the choice haunted him.',
      n.fate = 'Slew his friend Torgaddon on Isstvan III; later killed in the war he helped begin.';
MERGE (n:Character:Astartes {id: 'iacton-qruze'})
  SET n.name = 'Iacton Qruze', n.subtitle = 'The Half-heard',
      n.description = 'An old-blood veteran of the Luna Wolves, long out of favour and little heeded. When the Legion turned, the aged warrior found the courage to defect to the loyalists.',
      n.fate = 'Escaped aboard the Eisenstein and served the loyalist cause.',
      n.loreNote = 'A traitor-Legion veteran who chose loyalty late, carrying the old ways of the Luna Wolves.';
MERGE (n:Character:Astartes {id: 'saul-tarvitz'})
  SET n.name = 'Saul Tarvitz', n.subtitle = 'Captain, Emperor\'s Children',
      n.description = 'An unremarkable line officer whose honesty made him a hero. His desperate warning saved thousands of loyalists from the opening treachery of Isstvan III.',
      n.fate = 'Died defending the loyalist survivors on Isstvan III.';
MERGE (n:Character:Astartes {id: 'lucius'})
  SET n.name = 'Lucius', n.subtitle = 'Swordsman of the Emperor\'s Children',
      n.description = 'A peerless duellist consumed by vanity over his own skill. His pride drew him naturally into the embrace of Slaanesh.',
      n.fate = 'Cursed to be reborn through any who kill him while feeling satisfaction at his death.';
MERGE (n:Character:Astartes {id: 'eidolon'})
  SET n.name = 'Eidolon', n.subtitle = 'Lord Commander, Emperor\'s Children',
      n.description = 'An arrogant Lord Commander of the Third Legion, early to embrace excess. His sonic abilities presaged the Legion\'s descent into the Dark Prince\'s worship.';
MERGE (n:Character:Astartes {id: 'fabius'})
  SET n.name = 'Fabius', n.subtitle = 'Apothecary of the Emperor\'s Children',
      n.description = 'A chief apothecary who turned his craft toward forbidden flesh-science. He would become the Imperium\'s most notorious maker of monsters.';
MERGE (n:Character:Astartes {id: 'nathaniel-garro'})
  SET n.name = 'Nathaniel Garro', n.subtitle = 'Battle-Captain, Death Guard',
      n.description = 'A devout captain of the Death Guard who refused to betray his oaths. He commandeered the frigate Eisenstein to carry warning of the Heresy to Terra. He became one of the Emperor\'s first hidden agents.',
      n.fate = 'Survived to serve as an agent of the loyalist cause.',
      n.loreNote = 'A loyalist within a traitor Legion; his flight on the Eisenstein first warned Terra.';
MERGE (n:Character:Astartes {id: 'calas-typhon'})
  SET n.name = 'Calas Typhon', n.subtitle = 'First Captain, Death Guard',
      n.description = 'A grim captain and secret sorcerer who steered the Death Guard toward treachery. His bargain with the plague-god remade him into a herald of pestilence.',
      n.fate = 'Became Typhus, host of the Destroyer Hive and champion of Nurgle.';
MERGE (n:Character:Astartes {id: 'kharn'})
  SET n.name = 'Khârn', n.subtitle = 'Equerry of the World Eaters',
      n.description = 'Captain of the Eighth and equerry to Angron, once among the more level-headed of the World Eaters. The Butcher\'s Nails and Khorne\'s blessing drove him into unending slaughter.',
      n.fate = 'Became the infamous Betrayer, an eternal champion of Khorne.';
MERGE (n:Character:Astartes {id: 'erebus'})
  SET n.name = 'Erebus', n.subtitle = 'Dark Apostle, Word Bearers',
      n.description = 'The chief architect of the Heresy, a chaplain who schemed to damn the Imperium. He engineered Horus\'s wounding on Davin to deliver him to Chaos. Treacherous even to his own, he served only the dark gods.',
      n.motivations = 'To bring the whole of humanity into the worship of Chaos.';
MERGE (n:Character:Astartes {id: 'kor-phaeron'})
  SET n.name = 'Kor Phaeron', n.subtitle = 'First Captain, Word Bearers',
      n.description = 'The Dark Cardinal who raised Lorgar on Colchis and shaped his faith. Ambitious and ruthless, he led the assault on Calth. His zeal was matched only by his pride.',
      n.loreNote = 'Kor Phaeron was Lorgar\'s foster-father and early mentor on Colchis.';
MERGE (n:Character:Astartes {id: 'argel-tal'})
  SET n.name = 'Argel Tal', n.subtitle = 'Gal Vorbak, Word Bearers',
      n.description = 'A devoted captain of the Word Bearers, first of the possessed Gal Vorbak. He walked willingly into damnation out of loyalty and faith, and suffered for it.',
      n.fate = 'Slain by Kharn during the madness of the Shadow Crusade.';
MERGE (n:Character:Astartes {id: 'ahzek-ahriman'})
  SET n.name = 'Ahzek Ahriman', n.subtitle = 'Chief Librarian, Thousand Sons',
      n.description = 'The foremost sorcerer of the Thousand Sons after Magnus himself. His later attempt to save his mutating brothers would doom them to a worse fate. He is one of the setting\'s great tragic sorcerers.',
      n.motivations = 'To preserve his Legion and master forbidden knowledge.',
      n.image = 'assets/ahzek-ahriman.jpg';
MERGE (n:Character:Astartes {id: 'sigismund'})
  SET n.name = 'Sigismund', n.subtitle = 'First Captain, Imperial Fists',
      n.description = 'The greatest champion of the Imperial Fists and the Emperor\'s Champion in spirit. Grim and devout, he cut down traitors without number upon the walls of Terra.',
      n.fate = 'Survived the Siege; later first High Marshal of the Black Templars.';
MERGE (n:Character:Astartes {id: 'raldoron'})
  SET n.name = 'Raldoron', n.subtitle = 'Chapter Master, Blood Angels',
      n.description = 'First Captain and Chapter Master of the Blood Angels, Sanguinius\'s most trusted son. A steady and honourable commander through the darkest battles of the Heresy.';
MERGE (n:Character:Astartes {id: 'azkaellon'})
  SET n.name = 'Azkaellon', n.subtitle = 'Commander of the Sanguinary Guard',
      n.description = 'Leader of Sanguinius\'s golden bodyguard, fiercely protective of his primarch. He would not leave the angel\'s side even unto the end.';
MERGE (n:Character:Astartes {id: 'remus-ventanus'})
  SET n.name = 'Remus Ventanus', n.subtitle = 'Captain, Ultramarines',
      n.description = 'A captain of the Ultramarines who held firm during the treachery at Calth. His leadership helped save Ultramar from the Word Bearers\' opening blow.';
MERGE (n:Character:Astartes {id: 'artellus-numeon'})
  SET n.name = 'Artellus Numeon', n.subtitle = 'Equerry of the Salamanders',
      n.description = 'Vulkan\'s equerry and keeper of his Legion\'s faith after the Dropsite Massacre. He clung to the hope that his lost primarch would return.';
MERGE (n:Character:Astartes {id: 'shadrak-meduson'})
  SET n.name = 'Shadrak Meduson', n.subtitle = 'Warleader, Iron Hands',
      n.description = 'An Iron Hands captain who rallied the shattered loyalist Legions after the Dropsite Massacre. His guerrilla campaign struck back at the Warmaster\'s forces.';
MERGE (n:Character:Astartes {id: 'barabas-dantioch'})
  SET n.name = 'Barabas Dantioch', n.subtitle = 'Warsmith, Iron Warriors',
      n.description = 'A crippled but brilliant warsmith who stayed loyal to the Emperor. He held the fortress of the Schadenhold against his own treacherous Legion.',
      n.loreNote = 'A rare loyalist of the Iron Warriors, later key to the defence of the webway.';
MERGE (n:Character:Astartes {id: 'jago-sevatarion'})
  SET n.name = 'Jago Sevatarion', n.subtitle = 'First Captain, Night Lords',
      n.description = 'Called Sevatar, First Captain of the Night Lords and perhaps the deadliest of their number. Cynical and sharp-tongued, he saw his Legion and his primarch clearly, and served anyway.';
MERGE (n:Character:Astartes {id: 'shiban-khan'})
  SET n.name = 'Shiban Khan', n.subtitle = 'Khan of the White Scars',
      n.description = 'A brotherhood leader of the White Scars who embodied their ideals of speed and honour. The brutal fighting of the Heresy tested and changed him.';

// ---- Dreadnoughts ---------------------------------------------------------
MERGE (n:Character:Dreadnought {id: 'ancient-rylanor'})
  SET n.name = 'Ancient Rylanor', n.subtitle = 'Dreadnought of the Emperor\'s Children',
      n.description = 'The venerable Ancient of the Emperor\'s Children, interred in a dreadnought after grievous wounds. He refused to follow his Legion into damnation.',
      n.fate = 'Chose to die on Isstvan III rather than betray his oaths, denying the traitors his honour.',
      n.loreNote = 'A loyalist entombed within a traitor Legion.';
MERGE (n:Character:Dreadnought {id: 'cassian-dracos'})
  SET n.name = 'Cassian Dracos', n.subtitle = 'Dreadnought of the Iron Hands',
      n.description = 'A champion of the Iron Hands entombed in a contemptor-pattern war-engine. He fought on through the grief and fury that followed the death of Ferrus Manus.';
MERGE (n:Character:Dreadnought {id: 'telemechrus'})
  SET n.name = 'Telemechrus', n.subtitle = 'Dreadnought of the Ultramarines',
      n.description = 'A newly interred Ultramarines dreadnought who awoke to war during the treachery at Calth. Young in his sarcophagus, he learned the weight of his new form in battle.';

// ---- Chaos Gods -----------------------------------------------------------
MERGE (n:ChaosGod {id: 'khorne'})
  SET n.name = 'Khorne', n.subtitle = 'The Blood God', n.color = '#7a0f0f',
      n.description = 'The warp-power of rage, bloodshed and martial honour, who cares only that blood is spilled.';
MERGE (n:ChaosGod {id: 'nurgle'})
  SET n.name = 'Nurgle', n.subtitle = 'The Plague Father', n.color = '#5c6b2f',
      n.description = 'The warp-power of decay, disease and grim endurance, who loves his followers even as they rot.';
MERGE (n:ChaosGod {id: 'tzeentch'})
  SET n.name = 'Tzeentch', n.subtitle = 'The Changer of Ways', n.color = '#1f6f8b',
      n.description = 'The warp-power of ambition, sorcery and endless scheming, who weaves plots within plots.';
MERGE (n:ChaosGod {id: 'slaanesh'})
  SET n.name = 'Slaanesh', n.subtitle = 'The Dark Prince', n.color = '#9b3b7a',
      n.description = 'The warp-power of excess, perfection and desire, born of sensation pursued without limit.';
MERGE (n:ChaosGod {id: 'chaos-undivided'})
  SET n.name = 'Chaos Undivided', n.subtitle = 'The Primordial Truth', n.color = '#3a2a4a',
      n.kind = 'pantheon',
      n.description = 'The worship of the Ruinous Powers as one, the creed the Word Bearers named the Primordial Truth.';

// ---- Events ---------------------------------------------------------------
MERGE (n:Event {id: 'triumph-at-ullanor'})
  SET n.name = 'Triumph at Ullanor', n.subtitle = 'The Warmaster is named', n.order = 1,
      n.era = 'Great Crusade', n.location = 'Ullanor',
      n.description = 'The great victory-celebration where the Emperor named Horus Warmaster and departed for Terra, setting the stage for all that followed.';
MERGE (n:Event {id: 'censure-at-monarchia'})
  SET n.name = 'Censure at Monarchia', n.subtitle = 'The rebuke of Lorgar', n.order = 2,
      n.era = 'Great Crusade', n.location = 'Monarchia, Khur',
      n.description = 'The Emperor razed the perfect city Lorgar built in his worship and rebuked the Word Bearers for their faith, humiliating a primarch who would turn that faith to darker ends.';
MERGE (n:Event {id: 'council-of-nikaea'})
  SET n.name = 'Council of Nikaea', n.subtitle = 'The trial of sorcery', n.order = 3,
      n.era = 'Great Crusade', n.location = 'Nikaea',
      n.description = 'A great conclave convened to judge the use of psychic powers, ending in their prohibition and setting Magnus and the Thousand Sons on a collision course with the Emperor\'s law.';
MERGE (n:Event {id: 'davin'})
  SET n.name = 'The Fall at Davin', n.subtitle = 'The wounding of Horus', n.order = 4,
      n.era = 'Heresy', n.location = 'Davin',
      n.description = 'Horus was wounded by an anathame blade and, in a warp-born vision engineered by the Word Bearers, was turned against his father.';
MERGE (n:Event {id: 'isstvan-iii'})
  SET n.name = 'Isstvan III', n.subtitle = 'The purge of the loyal', n.order = 5,
      n.era = 'Heresy', n.location = 'Isstvan III',
      n.description = 'Horus virus-bombed his own loyal legionaries to purge dissent, triggering a desperate ground war among brothers and the first open bloodshed of the Heresy.';
MERGE (n:Event {id: 'isstvan-v'})
  SET n.name = 'Isstvan V — Dropsite Massacre', n.subtitle = 'The great betrayal', n.order = 6,
      n.era = 'Heresy', n.location = 'Isstvan V',
      n.description = 'Loyalist Legions landed to confront Horus, only for three Legions held in reserve to turn their guns on their brothers. The Iron Hands, Salamanders and Raven Guard were shattered.';
MERGE (n:Event {id: 'burning-of-prospero'})
  SET n.name = 'Burning of Prospero', n.subtitle = 'The fall of the Thousand Sons', n.order = 7,
      n.era = 'Heresy', n.location = 'Prospero',
      n.description = 'The Space Wolves, later joined by darker allies, destroyed the home of the Thousand Sons for their defiance of Nikaea — a censure that drove Magnus fully into the arms of Chaos.';
MERGE (n:Event {id: 'battle-of-calth'})
  SET n.name = 'Battle of Calth', n.subtitle = 'Treachery in Ultramar', n.order = 8,
      n.era = 'Heresy', n.location = 'Calth, Ultramar',
      n.description = 'The Word Bearers ambushed the Ultramarines at Calth, poisoning its star and forcing its people underground, opening the Shadow Crusade against Guilliman\'s realm.';
MERGE (n:Event {id: 'signus-campaign'})
  SET n.name = 'Signus Campaign', n.subtitle = 'The angel\'s trial', n.order = 9,
      n.era = 'Heresy', n.location = 'Signus Cluster',
      n.description = 'The Blood Angels were lured into a daemonic trap in the Signus Cluster, a snare meant to damn or destroy Sanguinius before the Siege.';
MERGE (n:Event {id: 'battle-of-phall'})
  SET n.name = 'Battle of Phall', n.subtitle = 'Void war of the IV and VII', n.order = 10,
      n.era = 'Heresy', n.location = 'Phall',
      n.description = 'A massive void engagement in which the Iron Warriors fell upon a loyalist Imperial Fists fleet, pitting Perturabo\'s cunning against Dorn\'s resolve.';
MERGE (n:Event {id: 'thramas-crusade'})
  SET n.name = 'Thramas Crusade', n.subtitle = 'Lion against the Night', n.order = 11,
      n.era = 'Heresy', n.location = 'Thramas Sector',
      n.description = 'A long shadow-war between the Dark Angels and the Night Lords, a duel of attrition that kept two Legions from the wider war.';
MERGE (n:Event {id: 'siege-of-terra'})
  SET n.name = 'Siege of Terra', n.subtitle = 'The final battle', n.order = 12,
      n.era = 'Heresy', n.location = 'Terra',
      n.description = 'The culminating assault of the Heresy, as Horus hurled his traitor Legions against the Imperial Palace in a battle that would decide the fate of humanity. It was fought over many months in distinct phases, each a war in itself.';
// ---- Siege of Terra — phase sub-events (each PART_OF siege-of-terra) --------
MERGE (n:Event {id: 'solar-war'})
  SET n.name = 'The Solar War', n.subtitle = 'The gates of the Solar System', n.order = 13,
      n.era = 'Heresy', n.location = 'Sol System',
      n.description = 'The opening phase of the Siege, a vast void war fought across the Solar System as the traitor armada broke through the outer defences to reach Terra itself.';
MERGE (n:Event {id: 'lions-gate'})
  SET n.name = 'Battle of the Lion\'s Gate', n.subtitle = 'The spaceport falls', n.order = 14,
      n.era = 'Heresy', n.location = 'Lion\'s Gate Spaceport, Terra',
      n.description = 'The traitors seized the colossal Lion\'s Gate spaceport, opening a landing-ground through which the bulk of the besieging host could pour onto the surface of Terra.';
MERGE (n:Event {id: 'saturnine'})
  SET n.name = 'The Saturnine Assault', n.subtitle = 'A wall given up to win the war', n.order = 15,
      n.era = 'Heresy', n.location = 'Saturnine Gate, Terra',
      n.description = 'A ferocious assault on the walls in which Dorn chose where to let the enemy believe they had broken through, trading a bastion to annihilate the traitors\' finest storm-troops.';
MERGE (n:Event {id: 'eternity-gate'})
  SET n.name = 'Battle at the Eternity Gate', n.subtitle = 'The last threshold', n.order = 16,
      n.era = 'Heresy', n.location = 'Eternity Gate, Inner Palace, Terra',
      n.description = 'The desperate defence of the final gateway to the Sanctum Imperialis, where loyalist champions and the Custodes held against the full fury of the traitor assault.';
MERGE (n:Event {id: 'inner-palace'})
  SET n.name = 'The Inner Palace', n.subtitle = 'The breaking of the shield', n.order = 17,
      n.era = 'Heresy', n.location = 'Inner Palace, Terra',
      n.description = 'The final battles within the Imperial Palace as Horus lowered the void shields and dared the Emperor aboard his flagship, drawing the war to its ruinous conclusion.';
MERGE (n:Event {id: 'boarding-vengeful-spirit'})
  SET n.name = 'Boarding of the Vengeful Spirit', n.subtitle = 'Father against son', n.order = 18,
      n.era = 'Heresy', n.location = 'Vengeful Spirit, above Terra',
      n.description = 'The Emperor teleported aboard Horus\'s flagship for the final confrontation. Sanguinius fell, and the Emperor at last struck down his favourite son at ruinous cost.';
