// ============================================================================
// CAST EXPANSION — the fuller named roster drawn from the event dossier
// (wh40k_heresy_event_participants.md). Idempotent MERGE on `id`.
//
// Scope: individuals the dossier names AND that can be placed with confidence
// (faction + role). Deep-cut names whose faction/role cannot be established
// without fabrication are intentionally omitted (lore discipline: omit the
// uncertain). Non-individual "forces" (Titan Legios, generic armies, fleets,
// taghmata) are not modelled — they are not individuals and have no label.
//
// Lore text is original high-level summary; contested points go in loreNote.
// New subtype labels: Custodes, SistersOfSilence, Mechanicum, Imperialis
// (humans/perpetuals); standalone Daemon (Neverborn, peer of ChaosGod).
// ============================================================================

// ---- Primarch (Alpha Legion's hidden twin) --------------------------------
MERGE (n:Character:Primarch {id: 'omegon'})
  SET n.name = 'Omegon', n.subtitle = 'The hidden twin of the Alpha Legion',
      n.description = 'The secret second primarch of the Twentieth, near-identical to Alpharius and forever masked behind him. The two ruled the Legion as one, trading identities so that no enemy could ever be certain which brother he faced.',
      n.motivations = 'The same unknowable design as his brother — perhaps a loyalty so deep it wears the mask of treachery.',
      n.loreNote = 'Alpharius and Omegon are twin primarchs who pose as one another; whether their rebellion served Chaos or a hidden loyalist purpose is the setting\'s great enigma.';

// ---- Adeptus Custodes ------------------------------------------------------
MERGE (n:Character:Custodes {id: 'constantin-valdor'})
  SET n.name = 'Constantin Valdor', n.subtitle = 'Captain-General of the Custodian Guard',
      n.description = 'First and foremost of the Emperor\'s golden guardians, keeper of the Sanctum and executor of his master\'s will. Where the primarchs were weapons of conquest, Valdor was the Emperor\'s shield and headsman both.';
MERGE (n:Character:Custodes {id: 'amon-tauromachian'})
  SET n.name = 'Amon Tauromachian', n.subtitle = 'Custodian, keeper of secrets',
      n.description = 'A senior Custodian entrusted with the Emperor\'s private counsels and the quiet errands that could be spoken to no one else.',
      n.loreNote = 'Not to be confused with Amon of the Thousand Sons. In some accounts a daemon wore his likeness to work deception at Nikaea — a face stolen, not the Custodian himself.';
MERGE (n:Character:Custodes {id: 'tsutomu'})
  SET n.name = 'Tsutomu', n.subtitle = 'Custodian Tribune',
      n.description = 'A tribune of the Ten Thousand who fought through the Siege of Terra, holding the inner thresholds of the Palace with cold, unbreakable precision.';
MERGE (n:Character:Custodes {id: 'diocletian-coros'})
  SET n.name = 'Diocletian Coros', n.subtitle = 'Custodian Prefect of the Webway',
      n.description = 'A prefect of the Custodes who commanded the desperate defence of the Imperial webway, the hidden war fought beneath the Palace while the Siege raged above.';
MERGE (n:Character:Custodes {id: 'caecaltus-dusk'})
  SET n.name = 'Caecaltus Dusk', n.subtitle = 'Custodian of the Ten Thousand',
      n.description = 'A Custodian who stood among the last defenders of the inner Palace, counted among the finest blades to guard the Eternity Gate.';

// ---- Sisters of Silence ----------------------------------------------------
MERGE (n:Character:SistersOfSilence {id: 'jenetia-krole'})
  SET n.name = 'Jenetia Krole', n.subtitle = 'Knight-Commander of the Silent Sisterhood',
      n.description = 'The mute mistress of the Sisters of Silence, whose null presence smothered sorcery and whose greatblade drank the lives of witches. She led her order at Prospero and upon the walls of Terra.';
MERGE (n:Character:SistersOfSilence {id: 'aphone-ire'})
  SET n.name = 'Aphone Ire', n.subtitle = 'Oblivion Knight, Sisters of Silence',
      n.description = 'An Oblivion Knight of the Silent Sisterhood who fought at the Siege, a living void against the warp-craft of the traitor host.';

// ---- Mechanicum ------------------------------------------------------------
MERGE (n:Character:Mechanicum {id: 'kelbor-hal'})
  SET n.name = 'Kelbor-Hal', n.subtitle = 'Fabricator-General of Mars',
      n.description = 'The supreme master of the Martian priesthood, who led the Mechanicum into schism and threw the forge-world\'s might behind the Warmaster.',
      n.loreNote = 'His turning dragged a civil war across Mars itself, the loyalist forges rising against the traitor Fabricator-General.';
MERGE (n:Character:Mechanicum {id: 'zagreus-kane'})
  SET n.name = 'Zagreus Kane', n.subtitle = 'Loyalist Magos of Mars',
      n.description = 'A high adept who kept faith with Terra through the Martian schism and carried the loyalist Mechanicum\'s cause to the defence of the Imperium.';
MERGE (n:Character:Mechanicum {id: 'sota-nul'})
  SET n.name = 'Sota-Nul', n.subtitle = 'Dark Magos of the Warmaster',
      n.description = 'An emissary of the traitor Mechanicum bound to Horus\'s service, her flesh and faith alike given over to the dark forge-craft of the rebellion.';
MERGE (n:Character:Mechanicum {id: 'meer-tawren'})
  SET n.name = 'Meer Edv Tawren', n.subtitle = 'Magos, Calth',
      n.description = 'A Mechanicum adept present in the Ultramar system during the treachery at Calth, whose expertise aided the loyalist struggle beneath the dying star.';
MERGE (n:Character:Mechanicum {id: 'cronn-barbarel'})
  SET n.name = 'Cronn Barbarel', n.subtitle = 'Magos, Calth',
      n.description = 'A Martian magos caught in the Word Bearers\' ambush at Calth, lending the loyalist defence the cold logic of the Machine-God.';

// ---- Imperialis (humans, officers, perpetuals) -----------------------------
MERGE (n:Character:Imperialis {id: 'malcador'})
  SET n.name = 'Malcador the Sigillite', n.subtitle = 'Regent of the Imperium',
      n.description = 'The Emperor\'s oldest confidant and second in all things, Lord of the Administratum and master of hidden agents. He bore the governance of the Imperium so his master could labour unseen, and spent himself utterly to hold the realm together.',
      n.fate = 'Took the Emperor\'s place upon the Golden Throne to sustain the Astronomican, and was consumed by it.';
MERGE (n:Character:Imperialis {id: 'kasper-hawser'})
  SET n.name = 'Kasper Hawser', n.subtitle = 'Skjald of the Space Wolves',
      n.description = 'A Terran scholar who gave up his old life to become a rememberer of the Space Wolves, carrying their sagas into the burning of Prospero.';
MERGE (n:Character:Imperialis {id: 'mahavastu-kallimakus'})
  SET n.name = 'Mahavastu Kallimakus', n.subtitle = 'Remembrancer of the Thousand Sons',
      n.description = 'Magnus\'s personal scribe, whose hand copied the sorcerer-king\'s words — and, unknowing, transcribed grimoires that would outlast Prospero.';
MERGE (n:Character:Imperialis {id: 'temba'})
  SET n.name = 'Eugan Temba', n.subtitle = 'Lost commander of Davin',
      n.description = 'Once a trusted Imperial commander left to govern Davin, he fell to the plague-lore of the moon and raised a corrupted host. His anathame blade dealt Horus the wound that doomed the Imperium.',
      n.loreNote = 'Spellings vary (Eugan / Eugen Temba) across accounts.';
MERGE (n:Character:Imperialis {id: 'akshub'})
  SET n.name = 'Akshub', n.subtitle = 'Priestess of the Serpent Lodge',
      n.description = 'A witch of Davin\'s Serpent Lodge who presided over the ritual that walked Horus through the warp and delivered his soul to the dark powers.';
MERGE (n:Character:Imperialis {id: 'vardus-praal'})
  SET n.name = 'Vardus Praal', n.subtitle = 'Planetary Governor of Isstvan',
      n.description = 'The rebel overlord of the Isstvan system whose warp-touched insurrection gave Horus the pretext to muster the Legions that he would turn to treachery.';
MERGE (n:Character:Imperialis {id: 'marcus-valerius'})
  SET n.name = 'Marcus Valerius', n.subtitle = 'Tribune of the Therion Cohort',
      n.description = 'A mortal officer of the Imperial Army whose faith and daring brought relief ships to the survivors of the Dropsite Massacre.';
MERGE (n:Character:Imperialis {id: 'admiral-klave'})
  SET n.name = 'Admiral Klave', n.subtitle = 'Imperial fleet officer',
      n.description = 'A naval commander of the loyalist expedition to Isstvan, whose ships bore the landing force into the trap that became the Dropsite Massacre.';
MERGE (n:Character:Imperialis {id: 'lord-commander-fayle'})
  SET n.name = 'Lord Commander Fayle', n.subtitle = 'Turncoat of the Imperial Army',
      n.description = 'An Army commander at Isstvan whose betrayal served the traitor cause when the reserve Legions turned their guns upon their brothers.';
MERGE (n:Character:Imperialis {id: 'colonel-sparzi'})
  SET n.name = 'Colonel Sparzi', n.subtitle = 'Army officer, Calth',
      n.description = 'A line colonel of the Imperial Army who held his troops together amid the orbital horror and underground war of Calth.';
MERGE (n:Character:Imperialis {id: 'saul-niborran'})
  SET n.name = 'Saul Niborran', n.subtitle = 'Lord Marshal of the Terran defence',
      n.description = 'A grizzled general of the Imperial Army given command of great swathes of the Palace wall, spending mortal lives by the million to buy the Siege another hour.';
MERGE (n:Character:Imperialis {id: 'ilya-ravallion'})
  SET n.name = 'Ilya Ravallion', n.subtitle = 'Mistress of the Logisticae',
      n.description = 'A brilliant logistician of the Imperial Army, keeper of the impossible sums that kept armies fed and moving through the Great Crusade and the Siege.';
MERGE (n:Character:Imperialis {id: 'ollanius-persson'})
  SET n.name = 'Ollanius Persson', n.subtitle = 'The Perpetual',
      n.description = 'A deathless soldier who had walked the human story since before the Imperium, drawn at the last to stand among the final defenders aboard the Warmaster\'s ship.',
      n.loreNote = 'The identity of the mortal who faced Horus has shifted across editions; here he is the perpetual Ollanius Persson.';
MERGE (n:Character:Imperialis {id: 'leetu'})
  SET n.name = 'Leetu', n.subtitle = 'The last loyal son',
      n.description = 'A legionary of uncertain making who kept a fierce, solitary loyalty to the Emperor, and who stood among the few at the final confrontation aboard the Vengeful Spirit.',
      n.loreNote = 'His true origin and allegiance are deliberately left ambiguous in the sources.';

// ---- Daemons (Neverborn) ---------------------------------------------------
MERGE (n:Daemon {id: 'kabandha'})
  SET n.name = 'Ka\'Bandha', n.subtitle = 'Bloodthirster of Khorne',
      n.description = 'A greater daemon of the Blood God and ancient hatred of the Blood Angels, loosed in the Signus Cluster to break Sanguinius and drown his sons in madness.';
MERGE (n:Daemon {id: 'kyriss'})
  SET n.name = 'Kyriss the Perverse', n.subtitle = 'Keeper of Secrets of Slaanesh',
      n.description = 'A greater daemon of the Dark Prince who sought to claim Sanguinius\'s soul amid the corrupted worlds of Signus.';
MERGE (n:Daemon {id: 'ygethddon'})
  SET n.name = 'Ygethddon', n.subtitle = 'Daemon of the Signus snare',
      n.description = 'One of the Neverborn loosed upon the Blood Angels in the Signus trap, a thing of the warp given shape by slaughter.';
MERGE (n:Daemon {id: 'corbax-utterblight'})
  SET n.name = 'Cor\'bax Utterblight', n.subtitle = 'Great Unclean One of Nurgle',
      n.description = 'A vast and rotting daemon of the Plague Father that oozed into the fighting at the Siege of Terra, spreading despair and corruption through the loyalist lines.';
MERGE (n:Daemon {id: 'vassukella'})
  SET n.name = 'Vassukella', n.subtitle = 'Keeper of Secrets of Slaanesh',
      n.description = 'A greater daemon of excess summoned into the Siege of Terra, a serpentine horror of the Dark Prince loosed within the Palace.';

// ---- Astartes (by Legion) --------------------------------------------------
// Sons of Horus
MERGE (n:Character:Astartes {id: 'lev-goshen'})
  SET n.name = 'Lev Goshen', n.subtitle = 'Captain, Sons of Horus',
      n.description = 'A captain of the Warmaster\'s Legion who fought through the final battles of the Siege of Terra.';
MERGE (n:Character:Astartes {id: 'argonis'})
  SET n.name = 'Kaeloron Argonis', n.subtitle = 'Emissary of the Warmaster',
      n.description = 'A captain of the Sons of Horus sent as Horus\'s envoy, bearer of the Warmaster\'s word to doubtful allies in the last days of the war.';
MERGE (n:Character:Astartes {id: 'hastur-sejanus'})
  SET n.name = 'Hastur Sejanus', n.subtitle = 'Lost son of the Mournival',
      n.description = 'A beloved member of the first Mournival, slain early in the wars of the Crusade.',
      n.loreNote = 'Long dead by the Heresy; what wears his face aboard the Vengeful Spirit is a warp-echo, not the man.';
// Emperor's Children
MERGE (n:Character:Astartes {id: 'vespasian'})
  SET n.name = 'Vespasian', n.subtitle = 'Lord Commander, Emperor\'s Children',
      n.description = 'A noble and temperate commander of the Third Legion who counselled restraint against the Legion\'s rising excess.',
      n.loreNote = 'His principled stance set him against Eidolon; he did not live to see Isstvan.';
MERGE (n:Character:Astartes {id: 'julius-kaesoron'})
  SET n.name = 'Julius Kaesoron', n.subtitle = 'First Captain, Emperor\'s Children',
      n.description = 'An early and eager convert to the pursuit of sensation, remade by the excesses of Slaanesh into a thing of ecstatic cruelty.';
MERGE (n:Character:Astartes {id: 'shabran-darr'})
  SET n.name = 'Shabran Darr', n.subtitle = 'Captain, Emperor\'s Children (loyal)',
      n.description = 'A line captain of the Third who kept faith with the Emperor and died among the loyalist stand on Isstvan III.';
// World Eaters
MERGE (n:Character:Astartes {id: 'morthax'})
  SET n.name = 'Morthax', n.subtitle = 'Equerry, World Eaters',
      n.description = 'An equerry to Angron who rode the red tide of the Legion\'s slaughter at the Dropsite Massacre.';
MERGE (n:Character:Astartes {id: 'calleb-decima'})
  SET n.name = 'Calleb Decima', n.subtitle = 'Captain, World Eaters (loyal)',
      n.description = 'A captain of the War Hounds who would not follow Angron into butchery, and fell with the loyalists purged on Isstvan III.';
// Death Guard
MERGE (n:Character:Astartes {id: 'durak-rask'})
  SET n.name = 'Durak Rask', n.subtitle = 'Commander, Death Guard',
      n.description = 'A Death Guard officer who served the treachery at Isstvan III as the Legion turned upon its own loyal brothers.';
MERGE (n:Character:Astartes {id: 'ullis-temeter'})
  SET n.name = 'Ullis Temeter', n.subtitle = 'Captain, Death Guard (loyal)',
      n.description = 'A well-loved captain of the Fourteenth who commanded loyalist survivors on the surface of Isstvan III, holding the line against the virus and the betrayers.';
MERGE (n:Character:Astartes {id: 'crysos-morturg'})
  SET n.name = 'Crysos Morturg', n.subtitle = 'Captain, Death Guard (loyal)',
      n.description = 'A Death Guard commander who escaped the purge of his Legion and fought on as a shadow-warrior against the traitor cause.';
MERGE (n:Character:Astartes {id: 'caipha-morarg'})
  SET n.name = 'Caipha Morarg', n.subtitle = 'Equerry, Death Guard',
      n.description = 'Mortarion\'s equerry, who bore his primarch\'s commands through the plague-ridden assault upon Terra.';
// Word Bearers
MERGE (n:Character:Astartes {id: 'xaphen'})
  SET n.name = 'Xaphen', n.subtitle = 'Chaplain, Word Bearers',
      n.description = 'A chaplain of the Seventeenth who knelt in the ashes of Monarchia and carried the Legion\'s wounded faith toward the Primordial Truth.';
MERGE (n:Character:Astartes {id: 'foedrall-fell'})
  SET n.name = 'Foedrall Fell', n.subtitle = 'Captain, Word Bearers',
      n.description = 'A commander of the Word Bearers in the opening treachery at Calth.';
MERGE (n:Character:Astartes {id: 'morpal-cxir'})
  SET n.name = 'Morpal Cxir', n.subtitle = 'Captain, Word Bearers',
      n.description = 'A Word Bearers officer who pressed the ground assault through the burning arcologies of Calth.';
MERGE (n:Character:Astartes {id: 'maloq-kartho'})
  SET n.name = 'Maloq Kartho', n.subtitle = 'Dark Apostle, Word Bearers',
      n.description = 'A dark apostle of the Seventeenth who worked ruinous rites amid the treachery at Calth.';
MERGE (n:Character:Astartes {id: 'sorot-tchure'})
  SET n.name = 'Sorot Tchure', n.subtitle = 'Captain, Word Bearers',
      n.description = 'A Word Bearers captain whose old friendship with an Ultramarine made his betrayal at Calth the more bitter.';
MERGE (n:Character:Astartes {id: 'kurtha-sedd'})
  SET n.name = 'Kurtha Sedd', n.subtitle = 'Chaplain, Word Bearers',
      n.description = 'A warrior-chaplain of the Word Bearers caught in the hell of Calth\'s poisoned war.';
MERGE (n:Character:Astartes {id: 'tanus-kreed'})
  SET n.name = 'Tanus Kreed', n.subtitle = 'Dark Apostle, Word Bearers',
      n.description = 'A Word Bearers apostle whose rites helped spring the daemonic snare upon the Blood Angels in the Signus Cluster.';
// Thousand Sons
MERGE (n:Character:Astartes {id: 'amon-thousand-sons'})
  SET n.name = 'Amon', n.subtitle = 'Equerry of Magnus, Thousand Sons',
      n.description = 'Tutelary and equerry to Magnus the Red, keeper of his primarch\'s conscience through the ruin of Prospero.',
      n.loreNote = 'Distinct from Amon Tauromachian of the Custodes.';
MERGE (n:Character:Astartes {id: 'phosis-tkar'})
  SET n.name = 'Phosis T\'Kar', n.subtitle = 'Magister of the Raptora, Thousand Sons',
      n.description = 'Master of the Raptora cult, whose telekinetic might was among the first weapons raised against the Wolves at Prospero.';
MERGE (n:Character:Astartes {id: 'khalophis'})
  SET n.name = 'Khalophis', n.subtitle = 'Magister of the Pyrae, Thousand Sons',
      n.description = 'Master of the fire-wielding Pyrae cult, who turned his pyromantic fury on the burning of his own city.';
MERGE (n:Character:Astartes {id: 'auramagma'})
  SET n.name = 'Auramagma', n.subtitle = 'Captain of the Pyrae, Thousand Sons',
      n.description = 'A fire-adept of the Thousand Sons whose power raged uncontrolled in the defence of Prospero.';
MERGE (n:Character:Astartes {id: 'ankhu-anen'})
  SET n.name = 'Ankhu Anen', n.subtitle = 'Guardian of the Great Library, Thousand Sons',
      n.description = 'Keeper of the vast library of Tizca, who watched ten thousand years of knowledge burn beneath the Wolves\' wrath.';
MERGE (n:Character:Astartes {id: 'sobek'})
  SET n.name = 'Sobek', n.subtitle = 'Practicus of Ahriman, Thousand Sons',
      n.description = 'A disciple of Ahzek Ahriman whose fate was bound to his master\'s desperate sorceries.';
MERGE (n:Character:Astartes {id: 'ignis'})
  SET n.name = 'Ignis', n.subtitle = 'Master of Ruin, Thousand Sons',
      n.description = 'A master of numbers and flame among the exiled Thousand Sons, who reckoned the fall of walls like equations at the Siege of Terra.';
// Space Wolves
MERGE (n:Character:Astartes {id: 'aun-helwintr'})
  SET n.name = 'Aun Helwintr', n.subtitle = 'Rune Priest, Space Wolves',
      n.description = 'A storm-caller of Fenris, one of the Wolves\' own witch-kind set against the sorcery of Prospero.';
MERGE (n:Character:Astartes {id: 'othere-wyrdmake'})
  SET n.name = 'Othere Wyrdmake', n.subtitle = 'Rune Priest, Space Wolves',
      n.description = 'A rune priest who sought the secrets of the Thousand Sons through false friendship, and helped set Wolf against Son.';
MERGE (n:Character:Astartes {id: 'elikas'})
  SET n.name = 'Elikas', n.subtitle = 'Warrior of the Space Wolves',
      n.description = 'A legionary of the Rout who marched in the censure-host sent to burn Prospero.';
MERGE (n:Character:Astartes {id: 'jormungndr'})
  SET n.name = 'Jormungndr Two-Blade', n.subtitle = 'Wolf Guard, Space Wolves',
      n.description = 'A fierce Wolf Guard who fought through the ruin of Tizca at his Jarl\'s side.';
MERGE (n:Character:Astartes {id: 'godsmote'})
  SET n.name = 'Godsmote', n.subtitle = 'Warrior of the Space Wolves',
      n.description = 'A legionary of Fenris who carried the saga of Prospero\'s burning home to the ice.';
MERGE (n:Character:Astartes {id: 'geigor-fell-hand'})
  SET n.name = 'Geigor Fell-Hand', n.subtitle = 'Wolf Guard, Space Wolves',
      n.description = 'A grim Wolf Guard of the Rout who fought in the great hunts of the Heresy.';
MERGE (n:Character:Astartes {id: 'bodvar-bjarki'})
  SET n.name = 'Bodvar Bjarki', n.subtitle = 'Jarl of the Space Wolves',
      n.description = 'A Jarl who led a Fenrisian detachment to the walls of Terra, a rare wolf among the Palace\'s defenders.';
// White Scars
MERGE (n:Character:Astartes {id: 'targutai-yesugei'})
  SET n.name = 'Targutai Yesugei', n.subtitle = 'Stormseer, White Scars',
      n.description = 'The foremost storm-seer of Chogoris and the Khan\'s conscience, who argued for the freedom of the psyker at Nikaea.';
MERGE (n:Character:Astartes {id: 'zhenjin-khan'})
  SET n.name = 'Zhenjin', n.subtitle = 'Khan of the White Scars',
      n.description = 'A brotherhood-khan of the Fifth caught in the long shadow-war of Thramas.',
      n.loreNote = 'His allegiance shifts across the Thramas material — an important case of divided loyalty within the White Scars.';
// Dark Angels
MERGE (n:Character:Astartes {id: 'alajos'})
  SET n.name = 'Alajos', n.subtitle = 'Captain, Dark Angels',
      n.description = 'A captain of the First Legion who fought the Night Lords through the attritional dark of the Thramas Crusade.';
MERGE (n:Character:Astartes {id: 'lord-cypher'})
  SET n.name = 'Lord Cypher', n.subtitle = 'Keeper of the Order, Dark Angels',
      n.description = 'An enigmatic office-bearer of the First Legion, custodian of old Calibanite rites, whose purposes answered to no one.',
      n.loreNote = 'Lord Cypher is a role as much as a person; his true loyalties are never made plain.';
// Night Lords
MERGE (n:Character:Astartes {id: 'krukesh'})
  SET n.name = 'Krukesh the Pale', n.subtitle = 'Captain, Night Lords',
      n.description = 'A cruel commander of the Eighth who rose amid the fractious terror-bands of the Night Lords.';
MERGE (n:Character:Astartes {id: 'gendor-skraivok'})
  SET n.name = 'Gendor Skraivok', n.subtitle = 'The Painted Count, Night Lords',
      n.description = 'A scheming captain of the Night Lords who brought his terror-host to the walls of Terra.';
// Iron Hands
MERGE (n:Character:Astartes {id: 'gabriel-santar'})
  SET n.name = 'Gabriel Santar', n.subtitle = 'First Captain, Iron Hands',
      n.description = 'Equerry and first captain to Ferrus Manus, who died with his primarch in the slaughter at Isstvan V.';
MERGE (n:Character:Astartes {id: 'castrmen-orth'})
  SET n.name = 'Castrmen Orth', n.subtitle = 'Clan Commander, Iron Hands',
      n.description = 'An Iron Hands officer of the Dropsite landing, caught in the betrayal that shattered the Tenth Legion.';
// Raven Guard
MERGE (n:Character:Astartes {id: 'agapito-nev'})
  SET n.name = 'Agapito', n.subtitle = 'Commander, Raven Guard',
      n.description = 'A fierce-hearted commander of the Raven Guard who survived the Dropsite Massacre to rebuild his broken Legion.';
MERGE (n:Character:Astartes {id: 'alvarex-maun'})
  SET n.name = 'Alvarex Maun', n.subtitle = 'Commander, Raven Guard',
      n.description = 'A Raven Guard officer among the survivors scattered by the treachery at Isstvan V.';
MERGE (n:Character:Astartes {id: 'branne-nev'})
  SET n.name = 'Branne', n.subtitle = 'Commander, Raven Guard',
      n.description = 'Brother to Agapito and a steadfast commander who held the Raven Guard together after the Massacre.';
// Emperor's Children (traitor, Dropsite) already above; Ultramarines
MERGE (n:Character:Astartes {id: 'eikos-lamiad'})
  SET n.name = 'Eikos Lamiad', n.subtitle = 'Tetrarch of Ultramar',
      n.description = 'A Tetrarch of Guilliman\'s realm who bore his primarch\'s authority through the treachery at Calth.';
MERGE (n:Character:Astartes {id: 'marius-gage'})
  SET n.name = 'Marius Gage', n.subtitle = 'Master of the First, Ultramarines',
      n.description = 'Senior captain of the Ultramarines and Guilliman\'s right hand, who rallied the Legion in the opening hours of the Calth betrayal.';
MERGE (n:Character:Astartes {id: 'steloc-aethon'})
  SET n.name = 'Steloc Aethon', n.subtitle = 'Captain, Ultramarines',
      n.description = 'An Ultramarines captain who fought to hold Calth\'s arcologies against the Word Bearers\' onslaught.';
MERGE (n:Character:Astartes {id: 'lyros-sydance'})
  SET n.name = 'Lyros Sydance', n.subtitle = 'Captain, Ultramarines',
      n.description = 'A line captain of the Thirteenth who led his companies through the underground war beneath the dying star of Calth.';
MERGE (n:Character:Astartes {id: 'tauro-nicodemus'})
  SET n.name = 'Tauro Nicodemus', n.subtitle = 'Officer, Ultramarines',
      n.description = 'An Ultramarines commander present at Calth in the hours of the great betrayal.';
// Blood Angels
MERGE (n:Character:Astartes {id: 'mkani-kano'})
  SET n.name = 'Mkani Kano', n.subtitle = 'Librarian, Blood Angels',
      n.description = 'A Librarian of the Blood Angels who set aside his powers at Nikaea\'s word, only to need them against the daemons of Signus.';
MERGE (n:Character:Astartes {id: 'meros'})
  SET n.name = 'Meros', n.subtitle = 'Apothecary, Blood Angels',
      n.description = 'An apothecary of the Ninth whose sacrifice in the Signus Cluster bought his primarch\'s life at a terrible price.';
MERGE (n:Character:Astartes {id: 'bel-sepatus'})
  SET n.name = 'Bel Sepatus', n.subtitle = 'Sanguinary Guard, Blood Angels',
      n.description = 'A commander of the Sanguinary Guard who fought at the side of the Angel through the Siege of Terra.';
// Salamanders
MERGE (n:Character:Astartes {id: 'atok-abidemi'})
  SET n.name = 'Atok Abidemi', n.subtitle = 'Captain, Salamanders',
      n.description = 'A Salamanders captain who brought the fire of Nocturne to the defence of the Imperial Palace.';
MERGE (n:Character:Astartes {id: 'barek-zytos'})
  SET n.name = 'Barek Zytos', n.subtitle = 'Terminator Captain, Salamanders',
      n.description = 'A grim Salamanders captain of the Siege, who fought in his primarch\'s name when Vulkan himself was lost.';
// Iron Warriors
MERGE (n:Character:Astartes {id: 'harkor'})
  SET n.name = 'Harkor', n.subtitle = 'Captain, Iron Warriors',
      n.description = 'An Iron Warriors officer of the Dropsite Massacre, a hammer of the siege-Legion.';
MERGE (n:Character:Astartes {id: 'erasmus-golg'})
  SET n.name = 'Erasmus Golg', n.subtitle = 'Captain, Iron Warriors',
      n.description = 'A commander of the Fourth who served Perturabo at Isstvan V and in the void war of Phall.';
MERGE (n:Character:Astartes {id: 'berossus'})
  SET n.name = 'Berossus', n.subtitle = 'Warsmith, Iron Warriors',
      n.description = 'A warsmith of the Iron Warriors in the great fleet engagement at Phall.';
MERGE (n:Character:Astartes {id: 'kroeger'})
  SET n.name = 'Kroeger', n.subtitle = 'Captain, Iron Warriors',
      n.description = 'An Iron Warriors commander who broke himself against the walls of Terra in the final siege.';
MERGE (n:Character:Astartes {id: 'barban-falk'})
  SET n.name = 'Barban Falk', n.subtitle = 'Warsmith, Iron Warriors',
      n.description = 'A warsmith of the Fourth who prosecuted Perturabo\'s cold science of destruction at the Siege of Terra.';
// Imperial Fists
MERGE (n:Character:Astartes {id: 'amandus-tyr'})
  SET n.name = 'Amandus Tyr', n.subtitle = 'Captain, Imperial Fists',
      n.description = 'A captain of the Seventh caught in the warp-storm-wracked battle at Phall.';
MERGE (n:Character:Astartes {id: 'captain-yonnad'})
  SET n.name = 'Yonnad', n.subtitle = 'Captain, Imperial Fists',
      n.description = 'The captain upon whom command of the Retribution Fleet fell at Phall when Sigismund was held back.';
MERGE (n:Character:Astartes {id: 'archamus'})
  SET n.name = 'Archamus', n.subtitle = 'Master of the Huscarls, Imperial Fists',
      n.description = 'Dorn\'s most trusted bodyguard and master of his Huscarls, who guarded the Praetorian through the Siege of Terra.';
MERGE (n:Character:Astartes {id: 'camba-diaz'})
  SET n.name = 'Camba Diaz', n.subtitle = 'Captain, Imperial Fists',
      n.description = 'An Imperial Fists captain who held a span of the Palace wall against the endless traitor assault.';
MERGE (n:Character:Astartes {id: 'maximus-thane'})
  SET n.name = 'Maximus Thane', n.subtitle = 'Captain, Imperial Fists',
      n.description = 'A dogged captain of the Seventh whose stand at the Siege would echo into the Legion\'s refounding.';
MERGE (n:Character:Astartes {id: 'diamantis'})
  SET n.name = 'Diamantis', n.subtitle = 'Standard-bearer, Imperial Fists',
      n.description = 'A huscarl of Rogal Dorn who bore his lord\'s standard into the final boarding of the Vengeful Spirit.';

// ============================================================================
// RELATIONSHIPS for the new cast
// ============================================================================

// ---- SON_OF / PRIMARCH_OF : Omegon ----------------------------------------
MATCH (o {id: 'omegon'}), (e {id: 'the-emperor'}) MERGE (o)-[:SON_OF]->(e);
MATCH (o {id: 'omegon'}), (l {id: 'alpha-legion'}) MERGE (o)-[:PRIMARCH_OF]->(l);

// ---- MEMBER_OF {role} : new Astartes -> legion -----------------------------
UNWIND [
  ['lev-goshen','sons-of-horus','Captain'],
  ['argonis','sons-of-horus','Emissary'],
  ['hastur-sejanus','sons-of-horus','Mournival (fallen)'],
  ['vespasian','emperors-children','Lord Commander'],
  ['julius-kaesoron','emperors-children','First Captain'],
  ['shabran-darr','emperors-children','Captain'],
  ['morthax','world-eaters','Equerry'],
  ['calleb-decima','world-eaters','Captain'],
  ['durak-rask','death-guard','Commander'],
  ['ullis-temeter','death-guard','Captain'],
  ['crysos-morturg','death-guard','Captain'],
  ['caipha-morarg','death-guard','Equerry'],
  ['xaphen','word-bearers','Chaplain'],
  ['foedrall-fell','word-bearers','Captain'],
  ['morpal-cxir','word-bearers','Captain'],
  ['maloq-kartho','word-bearers','Dark Apostle'],
  ['sorot-tchure','word-bearers','Captain'],
  ['kurtha-sedd','word-bearers','Chaplain'],
  ['tanus-kreed','word-bearers','Dark Apostle'],
  ['amon-thousand-sons','thousand-sons','Equerry'],
  ['phosis-tkar','thousand-sons','Magister (Raptora)'],
  ['khalophis','thousand-sons','Magister (Pyrae)'],
  ['auramagma','thousand-sons','Captain (Pyrae)'],
  ['ankhu-anen','thousand-sons','Guardian of the Library'],
  ['sobek','thousand-sons','Practicus'],
  ['ignis','thousand-sons','Master of Ruin'],
  ['aun-helwintr','space-wolves','Rune Priest'],
  ['othere-wyrdmake','space-wolves','Rune Priest'],
  ['elikas','space-wolves','Legionary'],
  ['jormungndr','space-wolves','Wolf Guard'],
  ['godsmote','space-wolves','Legionary'],
  ['geigor-fell-hand','space-wolves','Wolf Guard'],
  ['bodvar-bjarki','space-wolves','Jarl'],
  ['targutai-yesugei','white-scars','Stormseer'],
  ['zhenjin-khan','white-scars','Khan'],
  ['alajos','dark-angels','Captain'],
  ['lord-cypher','dark-angels','Keeper of the Order'],
  ['krukesh','night-lords','Captain'],
  ['gendor-skraivok','night-lords','Captain'],
  ['gabriel-santar','iron-hands','First Captain'],
  ['castrmen-orth','iron-hands','Clan Commander'],
  ['agapito-nev','raven-guard','Commander'],
  ['alvarex-maun','raven-guard','Commander'],
  ['branne-nev','raven-guard','Commander'],
  ['eikos-lamiad','ultramarines','Tetrarch'],
  ['marius-gage','ultramarines','Master of the First'],
  ['steloc-aethon','ultramarines','Captain'],
  ['lyros-sydance','ultramarines','Captain'],
  ['tauro-nicodemus','ultramarines','Officer'],
  ['mkani-kano','blood-angels','Librarian'],
  ['meros','blood-angels','Apothecary'],
  ['bel-sepatus','blood-angels','Sanguinary Guard'],
  ['atok-abidemi','salamanders','Captain'],
  ['barek-zytos','salamanders','Terminator Captain'],
  ['harkor','iron-warriors','Captain'],
  ['erasmus-golg','iron-warriors','Captain'],
  ['berossus','iron-warriors','Warsmith'],
  ['kroeger','iron-warriors','Captain'],
  ['barban-falk','iron-warriors','Warsmith'],
  ['amandus-tyr','imperial-fists','Captain'],
  ['captain-yonnad','imperial-fists','Captain'],
  ['archamus','imperial-fists','Master of the Huscarls'],
  ['camba-diaz','imperial-fists','Captain'],
  ['maximus-thane','imperial-fists','Captain'],
  ['diamantis','imperial-fists','Huscarl']
] AS m
MATCH (c {id: m[0]}), (l {id: m[1]})
MERGE (c)-[r:MEMBER_OF]->(l) SET r.role = m[2];

// ---- SIDED_WITH : new characters & daemons -> allegiance -------------------
UNWIND [
  // loyalists
  ['omegon','traitor'],
  ['constantin-valdor','loyalist'],['amon-tauromachian','loyalist'],['tsutomu','loyalist'],
  ['diocletian-coros','loyalist'],['caecaltus-dusk','loyalist'],
  ['jenetia-krole','loyalist'],['aphone-ire','loyalist'],
  ['zagreus-kane','loyalist'],['meer-tawren','loyalist'],['cronn-barbarel','loyalist'],
  ['malcador','loyalist'],['kasper-hawser','loyalist'],['mahavastu-kallimakus','loyalist'],
  ['marcus-valerius','loyalist'],['admiral-klave','loyalist'],['colonel-sparzi','loyalist'],
  ['saul-niborran','loyalist'],['ilya-ravallion','loyalist'],['ollanius-persson','loyalist'],
  ['leetu','loyalist'],
  ['vespasian','loyalist'],['shabran-darr','loyalist'],['calleb-decima','loyalist'],
  ['ullis-temeter','loyalist'],['crysos-morturg','loyalist'],
  ['aun-helwintr','loyalist'],['othere-wyrdmake','loyalist'],['elikas','loyalist'],
  ['jormungndr','loyalist'],['godsmote','loyalist'],['geigor-fell-hand','loyalist'],
  ['bodvar-bjarki','loyalist'],['targutai-yesugei','loyalist'],['zhenjin-khan','loyalist'],
  ['alajos','loyalist'],['lord-cypher','loyalist'],
  ['gabriel-santar','loyalist'],['castrmen-orth','loyalist'],
  ['agapito-nev','loyalist'],['alvarex-maun','loyalist'],['branne-nev','loyalist'],
  ['eikos-lamiad','loyalist'],['marius-gage','loyalist'],['steloc-aethon','loyalist'],
  ['lyros-sydance','loyalist'],['tauro-nicodemus','loyalist'],
  ['mkani-kano','loyalist'],['meros','loyalist'],['bel-sepatus','loyalist'],
  ['atok-abidemi','loyalist'],['barek-zytos','loyalist'],
  ['amandus-tyr','loyalist'],['captain-yonnad','loyalist'],['archamus','loyalist'],
  ['camba-diaz','loyalist'],['maximus-thane','loyalist'],['diamantis','loyalist'],
  // traitors
  ['kelbor-hal','traitor'],['sota-nul','traitor'],
  ['temba','traitor'],['akshub','traitor'],['vardus-praal','traitor'],['lord-commander-fayle','traitor'],
  ['lev-goshen','traitor'],['argonis','traitor'],['hastur-sejanus','traitor'],
  ['julius-kaesoron','traitor'],['morthax','traitor'],['durak-rask','traitor'],['caipha-morarg','traitor'],
  ['xaphen','traitor'],['foedrall-fell','traitor'],['morpal-cxir','traitor'],['maloq-kartho','traitor'],
  ['sorot-tchure','traitor'],['kurtha-sedd','traitor'],['tanus-kreed','traitor'],
  ['amon-thousand-sons','traitor'],['phosis-tkar','traitor'],['khalophis','traitor'],
  ['auramagma','traitor'],['ankhu-anen','traitor'],['sobek','traitor'],['ignis','traitor'],
  ['krukesh','traitor'],['gendor-skraivok','traitor'],
  ['harkor','traitor'],['erasmus-golg','traitor'],['berossus','traitor'],['kroeger','traitor'],['barban-falk','traitor'],
  // daemons march with the traitor cause
  ['kabandha','traitor'],['kyriss','traitor'],['ygethddon','traitor'],
  ['corbax-utterblight','traitor'],['vassukella','traitor']
] AS s
MATCH (c {id: s[0]}), (a {id: s[1]})
MERGE (c)-[:SIDED_WITH]->(a);

// ---- DEVOTED_TO {degree} : daemons -> patron god ---------------------------
UNWIND [
  ['kabandha','khorne','sworn'],['ygethddon','khorne','sworn'],
  ['kyriss','slaanesh','sworn'],['vassukella','slaanesh','sworn'],
  ['corbax-utterblight','nurgle','sworn']
] AS d
MATCH (c {id: d[0]}), (g {id: d[1]})
MERGE (c)-[r:DEVOTED_TO]->(g) SET r.degree = d[2];
