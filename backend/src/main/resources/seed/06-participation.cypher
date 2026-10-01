// ============================================================================
// PARTICIPATION — event edges for the expanded cast, with presence semantics.
// Idempotent. presence ∈ physical|supporting|strategic|psychic|vision|
// aftermath|reinforcement. The dossier's DIRECT lists become `physical`; its
// "DO NOT mark / strategic / vision" notes become a non-physical presence.
// ============================================================================

// ---- Physical participation : [id, event, side, role] ----------------------
UNWIND [
  // Triumph at Ullanor — the primarchs and dignitaries who attended the parade
  ['sanguinius','triumph-at-ullanor','imperial','Attended the Triumph'],
  ['mortarion','triumph-at-ullanor','imperial','Attended the Triumph'],
  ['magnus-the-red','triumph-at-ullanor','imperial','Attended the Triumph'],
  ['angron','triumph-at-ullanor','imperial','Attended the Triumph'],
  ['jaghatai-khan','triumph-at-ullanor','imperial','Attended the Triumph'],
  ['lorgar','triumph-at-ullanor','imperial','Attended the Triumph'],
  ['rogal-dorn','triumph-at-ullanor','imperial','Attended the Triumph'],
  ['fulgrim','triumph-at-ullanor','imperial','Attended the Triumph'],
  ['malcador','triumph-at-ullanor','imperial','Attended the Triumph'],
  ['constantin-valdor','triumph-at-ullanor','imperial','Guarded the Emperor'],

  // Censure at Monarchia — those made to kneel / to witness
  ['argel-tal','censure-at-monarchia','imperial','Among the kneeling'],
  ['xaphen','censure-at-monarchia','imperial','Among the kneeling'],
  ['malcador','censure-at-monarchia','imperial','Witnessed the rebuke'],

  // Council of Nikaea — named attendees of the great conclave
  ['ahzek-ahriman','council-of-nikaea','imperial','Attended'],
  ['amon-thousand-sons','council-of-nikaea','imperial','Attended'],
  ['amon-tauromachian','council-of-nikaea','imperial','Attended'],
  ['amit','council-of-nikaea','imperial','Attended'],
  ['aun-helwintr','council-of-nikaea','imperial','Attended'],
  ['bjorn','council-of-nikaea','imperial','Attended'],
  ['calas-typhon','council-of-nikaea','imperial','Attended'],
  ['constantin-valdor','council-of-nikaea','imperial','Marshalled the conclave'],
  ['corvus-corax','council-of-nikaea','imperial','Attended'],
  ['eidolon','council-of-nikaea','imperial','Attended'],
  ['elikas','council-of-nikaea','imperial','Attended'],
  ['fulgrim','council-of-nikaea','imperial','Attended'],
  ['kasper-hawser','council-of-nikaea','imperial','Attended'],
  ['kelbor-hal','council-of-nikaea','imperial','Attended'],
  ['leman-russ','council-of-nikaea','imperial','Attended'],
  ['mahavastu-kallimakus','council-of-nikaea','imperial','Attended'],
  ['malcador','council-of-nikaea','imperial','Attended'],
  ['mortarion','council-of-nikaea','imperial','Attended'],
  ['othere-wyrdmake','council-of-nikaea','imperial','Attended'],
  ['raldoron','council-of-nikaea','imperial','Attended'],
  ['rogal-dorn','council-of-nikaea','imperial','Attended'],
  ['sanguinius','council-of-nikaea','imperial','Attended'],
  ['targutai-yesugei','council-of-nikaea','imperial','Spoke for the psyker'],
  ['vespasian','council-of-nikaea','imperial','Attended'],

  // The Fall at Davin — the ritual and its perpetrators / enemy
  ['temba','davin','traitor','Wielder of the anathame'],
  ['akshub','davin','traitor','Serpent Lodge ritualist'],

  // Isstvan III — the purge of the loyal
  ['durak-rask','isstvan-iii','traitor','Death Guard commander'],
  ['vardus-praal','isstvan-iii','traitor','Isstvanian rebel overlord'],
  ['shabran-darr','isstvan-iii','loyalist','Among the loyalist stand'],
  ['ullis-temeter','isstvan-iii','loyalist','Commanded loyalist survivors'],
  ['crysos-morturg','isstvan-iii','loyalist','Among the loyalist stand'],
  ['calleb-decima','isstvan-iii','loyalist','Among the loyalist stand'],

  // Isstvan V — the Dropsite Massacre
  ['gabriel-santar','isstvan-v','loyalist','Slain with Ferrus Manus'],
  ['castrmen-orth','isstvan-v','loyalist','Dropsite landing'],
  ['agapito-nev','isstvan-v','loyalist','Survivor'],
  ['alvarex-maun','isstvan-v','loyalist','Survivor'],
  ['branne-nev','isstvan-v','loyalist','Survivor'],
  ['julius-kaesoron','isstvan-v','traitor','First Captain'],
  ['morthax','isstvan-v','traitor','Equerry of Angron'],
  ['harkor','isstvan-v','traitor','Iron Warriors captain'],
  ['erasmus-golg','isstvan-v','traitor','Iron Warriors captain'],
  ['omegon','isstvan-v','traitor','Among the reserve that turned'],
  ['lord-commander-fayle','isstvan-v','traitor','Turncoat commander'],

  // Burning of Prospero — Wolves and Custodes against the Thousand Sons
  ['aun-helwintr','burning-of-prospero','loyalist','Rune Priest'],
  ['othere-wyrdmake','burning-of-prospero','loyalist','Rune Priest'],
  ['elikas','burning-of-prospero','loyalist','Legionary'],
  ['jormungndr','burning-of-prospero','loyalist','Wolf Guard'],
  ['godsmote','burning-of-prospero','loyalist','Legionary'],
  ['geigor-fell-hand','burning-of-prospero','loyalist','Wolf Guard'],
  ['constantin-valdor','burning-of-prospero','loyalist','Custodian host'],
  ['amon-tauromachian','burning-of-prospero','loyalist','Custodian host'],
  ['jenetia-krole','burning-of-prospero','loyalist','Silent Sisterhood'],
  ['phosis-tkar','burning-of-prospero','traitor','Defender of Prospero'],
  ['khalophis','burning-of-prospero','traitor','Defender of Prospero'],
  ['auramagma','burning-of-prospero','traitor','Defender of Prospero'],
  ['ankhu-anen','burning-of-prospero','traitor','Defender of the Library'],
  ['sobek','burning-of-prospero','traitor','Defender of Prospero'],
  ['amon-thousand-sons','burning-of-prospero','traitor','Defender of Prospero'],

  // Battle of Calth — the treachery in Ultramar
  ['foedrall-fell','battle-of-calth','traitor','Word Bearers captain'],
  ['morpal-cxir','battle-of-calth','traitor','Word Bearers captain'],
  ['maloq-kartho','battle-of-calth','traitor','Dark Apostle'],
  ['sorot-tchure','battle-of-calth','traitor','Word Bearers captain'],
  ['kurtha-sedd','battle-of-calth','traitor','Chaplain'],
  ['eikos-lamiad','battle-of-calth','loyalist','Tetrarch'],
  ['marius-gage','battle-of-calth','loyalist','Master of the First'],
  ['steloc-aethon','battle-of-calth','loyalist','Captain'],
  ['lyros-sydance','battle-of-calth','loyalist','Captain'],
  ['tauro-nicodemus','battle-of-calth','loyalist','Officer'],
  ['colonel-sparzi','battle-of-calth','loyalist','Army colonel'],

  // Signus Campaign — the Blood Angels in the daemon snare
  ['mkani-kano','signus-campaign','loyalist','Librarian'],
  ['meros','signus-campaign','loyalist','Apothecary'],
  ['kabandha','signus-campaign','traitor','Bloodthirster of the snare'],
  ['kyriss','signus-campaign','traitor','Keeper of Secrets'],
  ['ygethddon','signus-campaign','traitor','Daemon of the snare'],
  ['tanus-kreed','signus-campaign','traitor','Word Bearers apostle'],

  // Battle of Phall — the Iron Warriors and Imperial Fists in the void
  ['berossus','battle-of-phall','traitor','Warsmith'],
  ['erasmus-golg','battle-of-phall','traitor','Iron Warriors captain'],
  ['amandus-tyr','battle-of-phall','loyalist','Captain'],
  ['captain-yonnad','battle-of-phall','loyalist','Commander of the Retribution Fleet'],

  // Thramas Crusade — Lion against the Night
  ['alajos','thramas-crusade','loyalist','Captain'],
  ['krukesh','thramas-crusade','traitor','Night Lords captain'],
  ['zhenjin-khan','thramas-crusade','loyalist','Khan of divided loyalty'],

  // Siege of Terra (umbrella) — traitor primarchs & host
  ['perturabo','siege-of-terra','traitor','Lord of the siege-works'],
  ['angron','siege-of-terra','traitor','Daemon-primarch of the World Eaters'],
  ['magnus-the-red','siege-of-terra','traitor','Daemon-primarch of the Thousand Sons'],
  ['fulgrim','siege-of-terra','traitor','Daemon-primarch of the Emperor\'s Children'],
  ['sota-nul','siege-of-terra','traitor','Dark Mechanicum'],
  ['lev-goshen','siege-of-terra','traitor','Sons of Horus captain'],
  ['caipha-morarg','siege-of-terra','traitor','Mortarion\'s equerry'],
  ['ignis','siege-of-terra','traitor','Master of Ruin'],
  ['kroeger','siege-of-terra','traitor','Iron Warriors captain'],
  ['barban-falk','siege-of-terra','traitor','Warsmith'],
  ['gendor-skraivok','siege-of-terra','traitor','Night Lords captain'],
  ['calas-typhon','siege-of-terra','traitor','Herald of the Destroyer Hive'],
  ['ahzek-ahriman','siege-of-terra','traitor','Exiled sorcerer'],
  ['amon-thousand-sons','siege-of-terra','traitor','Thousand Sons'],
  ['erebus','siege-of-terra','traitor','Dark Apostle'],
  ['corbax-utterblight','siege-of-terra','traitor','Great Unclean One'],
  ['vassukella','siege-of-terra','traitor','Keeper of Secrets'],
  ['kabandha','siege-of-terra','traitor','Bloodthirster'],
  // Siege of Terra (umbrella) — loyalist defenders
  ['vulkan','siege-of-terra','loyalist','Lord of the Salamanders'],
  ['constantin-valdor','siege-of-terra','loyalist','Captain-General'],
  ['jenetia-krole','siege-of-terra','loyalist','Silent Sisterhood'],
  ['aphone-ire','siege-of-terra','loyalist','Oblivion Knight'],
  ['zagreus-kane','siege-of-terra','loyalist','Loyalist Mechanicum'],
  ['tsutomu','siege-of-terra','loyalist','Custodian Tribune'],
  ['diocletian-coros','siege-of-terra','loyalist','Prefect of the webway'],
  ['caecaltus-dusk','siege-of-terra','loyalist','Custodian'],
  ['archamus','siege-of-terra','loyalist','Master of the Huscarls'],
  ['camba-diaz','siege-of-terra','loyalist','Captain'],
  ['maximus-thane','siege-of-terra','loyalist','Captain'],
  ['diamantis','siege-of-terra','loyalist','Huscarl'],
  ['bel-sepatus','siege-of-terra','loyalist','Sanguinary Guard'],
  ['bodvar-bjarki','siege-of-terra','loyalist','Fenrisian Jarl'],
  ['atok-abidemi','siege-of-terra','loyalist','Salamanders captain'],
  ['barek-zytos','siege-of-terra','loyalist','Salamanders captain'],
  ['lord-cypher','siege-of-terra','loyalist','Dark Angels contingent'],
  ['corswain','siege-of-terra','loyalist','Dark Angels contingent'],
  ['garviel-loken','siege-of-terra','loyalist','Knight-Errant'],
  ['nathaniel-garro','siege-of-terra','loyalist','Knight-Errant'],

  // Boarding of the Vengeful Spirit — the actual boarding force
  ['constantin-valdor','boarding-vengeful-spirit','loyalist','Custodian boarding party'],
  ['raldoron','boarding-vengeful-spirit','loyalist','Blood Angels first company'],
  ['diamantis','boarding-vengeful-spirit','loyalist','Dorn\'s standard-bearer'],
  ['ezekyle-abaddon','boarding-vengeful-spirit','traitor','First Captain'],
  ['erebus','boarding-vengeful-spirit','traitor','Dark Apostle'],
  ['argonis','boarding-vengeful-spirit','traitor','Emissary'],
  ['garviel-loken','boarding-vengeful-spirit','loyalist','Final confrontation'],
  ['leetu','boarding-vengeful-spirit','loyalist','Final confrontation'],
  ['ollanius-persson','boarding-vengeful-spirit','loyalist','Stood against the Warmaster']
] AS p
MATCH (c {id: p[0]}), (e {id: p[1]})
MERGE (c)-[r:PARTICIPATED_IN]->(e) SET r.side = p[2], r.role = p[3], r.presence = 'physical';

// ---- Non-physical presence : [id, event, side, role, presence] -------------
UNWIND [
  // Davin — the Mournival tended the wounded Warmaster; Magnus saw it from afar
  ['ezekyle-abaddon','davin','imperial','Mournival','supporting'],
  ['horus-aximand','davin','imperial','Mournival','supporting'],
  ['garviel-loken','davin','imperial','Mournival','supporting'],
  ['tarik-torgaddon','davin','imperial','Mournival','supporting'],
  ['magnus-the-red','davin','imperial','Distant psychic witness','psychic'],

  // Signus — Horus dispatched the Blood Angels; Erebus advised the snare
  ['horus-lupercal','signus-campaign','traitor','Dispatched the Blood Angels','strategic'],
  ['erebus','signus-campaign','traitor','Advised the snare','strategic'],

  // Isstvan V — a mortal relief effort reached the survivors
  ['marcus-valerius','isstvan-v','loyalist','Brought relief ships','supporting'],
  ['admiral-klave','isstvan-v','loyalist','Fleet command','supporting'],

  // Prospero — remembrancer/skjald present but not as combatants
  ['kasper-hawser','burning-of-prospero','loyalist','Skjald','supporting'],
  ['mahavastu-kallimakus','burning-of-prospero','traitor','Remembrancer','supporting'],

  // Calth — Mechanicum support beneath the dying star
  ['meer-tawren','battle-of-calth','loyalist','Magos','supporting'],
  ['cronn-barbarel','battle-of-calth','loyalist','Magos','supporting'],

  // Phall — §15: Sigismund was named to lead but never deployed
  ['sigismund','battle-of-phall','loyalist','Intended commander (did not deploy)','strategic'],

  // Siege — strategic & supporting actors (not front-line physical)
  ['malcador','siege-of-terra','loyalist','Sustained the defence from the Throne','supporting'],
  ['kelbor-hal','siege-of-terra','traitor','Martian traitor forge-lord','strategic'],
  ['saul-niborran','siege-of-terra','loyalist','Lord Marshal of the wall','physical'],
  ['ilya-ravallion','siege-of-terra','loyalist','Mistress of the Logisticae','supporting'],

  // Boarding — supporting operations elsewhere; and warp manifestations
  ['malcador','boarding-vengeful-spirit','loyalist','Sustained the operation','supporting'],
  ['vulkan','boarding-vengeful-spirit','loyalist','Remained at Terra','supporting'],
  ['archamus','boarding-vengeful-spirit','loyalist','Commanding remaining forces','supporting'],
  ['corswain','boarding-vengeful-spirit','loyalist','Simultaneous operation','supporting'],
  ['lord-cypher','boarding-vengeful-spirit','loyalist','Simultaneous operation','supporting'],
  ['calas-typhon','boarding-vengeful-spirit','traitor','Simultaneous operation','supporting'],
  ['ferrus-manus','boarding-vengeful-spirit','loyalist','Warp-echo','vision'],
  ['hastur-sejanus','boarding-vengeful-spirit','traitor','Warp-echo','vision'],
  ['zardu-layak','boarding-vengeful-spirit','traitor','Daemonic manifestation','vision']
] AS p
MATCH (c {id: p[0]}), (e {id: p[1]})
MERGE (c)-[r:PARTICIPATED_IN]->(e) SET r.side = p[2], r.role = p[3], r.presence = p[4];

// ---- Siege phase participation : [id, phase, side, role] (all physical) ----
UNWIND [
  // The Solar War — the void war at the gates of Sol
  ['horus-lupercal','solar-war','traitor','Warmaster of the armada'],
  ['perturabo','solar-war','traitor','Master of the assault'],
  // Battle of the Lion's Gate — the descent of the Angel
  ['sanguinius','lions-gate','loyalist','Descent of the Angel'],
  ['zephon','lions-gate','loyalist','Sanguinary Guard'],
  ['kharn','lions-gate','traitor','Stormed the spaceport'],
  // The Saturnine Assault — Dorn\'s gambit
  ['rogal-dorn','saturnine','loyalist','Architect of the Saturnine gambit'],
  ['sigismund','saturnine','loyalist','Champion'],
  ['fafnir-rann','saturnine','loyalist','Huscarl'],
  ['ezekyle-abaddon','saturnine','traitor','Led the Justaerin'],
  ['forrix','saturnine','traitor','Triarch of the breach'],
  // Battle at the Eternity Gate — the last threshold
  ['sanguinius','eternity-gate','loyalist','Held the threshold'],
  ['constantin-valdor','eternity-gate','loyalist','Captain-General'],
  ['caecaltus-dusk','eternity-gate','loyalist','Custodian'],
  ['sigismund','eternity-gate','loyalist','Emperor\'s Champion'],
  // The Inner Palace — the breaking of the shield
  ['horus-lupercal','inner-palace','traitor','Lowered the void shields'],
  ['rogal-dorn','inner-palace','loyalist','Praetorian of Terra'],
  ['sanguinius','inner-palace','loyalist','Last defence']
] AS p
MATCH (c {id: p[0]}), (e {id: p[1]})
MERGE (c)-[r:PARTICIPATED_IN]->(e) SET r.side = p[2], r.role = p[3], r.presence = 'physical';

// ---- FOUGHT_IN additions : legion -> event ---------------------------------
UNWIND [
  ['word-bearers','signus-campaign','traitor'],
  ['space-wolves','signus-campaign','loyalist'],
  // Siege phases
  ['imperial-fists','solar-war','loyalist'],['sons-of-horus','solar-war','traitor'],
  ['imperial-fists','lions-gate','loyalist'],['blood-angels','lions-gate','loyalist'],
  ['sons-of-horus','lions-gate','traitor'],['world-eaters','lions-gate','traitor'],
  ['imperial-fists','saturnine','loyalist'],['sons-of-horus','saturnine','traitor'],
  ['iron-warriors','saturnine','traitor'],
  ['imperial-fists','eternity-gate','loyalist'],['blood-angels','eternity-gate','loyalist'],
  ['sons-of-horus','inner-palace','traitor'],['iron-warriors','inner-palace','traitor'],
  ['death-guard','inner-palace','traitor'],['imperial-fists','inner-palace','loyalist']
] AS f
MATCH (l {id: f[0]}), (e {id: f[1]})
MERGE (l)-[r:FOUGHT_IN]->(e) SET r.side = f[2];
