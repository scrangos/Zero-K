unitDef = {
  unitname            = [[corfast]],
  name                = [[Freaker]],
  description         = [[Jumpjet Constructor/Resurrector, Builds at 9 m/s]],
  acceleration        = 0.26,
  bmcode              = [[1]],
  brakeRate           = 0.26,
  buildCostEnergy     = 240,
  buildCostMetal      = 240,
  buildDistance       = 120,
  builder             = true,

  buildoptions        = {
  },

  buildPic            = [[CORFAST.png]],
  buildTime           = 240,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canreclamate        = [[1]],
  canResurrect        = true,
  canstop             = [[1]],
  category            = [[LAND UNARMED]],
  corpse              = [[DEAD]],

  customParams        = {
    canjump        = [[1]],
    description_bp = [[Construtor saltador, produz a 9 m/s]],
    description_es = [[Constructor jumpjet, construye a 9 m/s]],
    description_fr = [[Constructeur r Jetpack, Construit r 9 m/s]],
    description_it = [[Costruttore jumpjet, costruisce a 9 m/s]],
	description_de = [[Konstruktionsjumpjet, Baut mit 9 M/s]],
    helptext       = [[Fast and capable of jumping over short distances or heights, the Freaker is the ideal constructor for rapid expansion.]],
    helptext_bp    = [[Rápido e capaz de saltar por sobre distâncias curtas ou pequenos obstáculos, Freaker é ideal para expans?o rápida.]],
    helptext_es    = [[Rápido y capaz de brincar sobre cortas distancias o alturas, el Freaker es el constructor ideal para la expansión rápida]],
    helptext_fr    = [[R la fois rapide et capable de sauter sur de courtes distances grâce r son jetpack, le Freaker est un superbe outil pour favoriser son expansion.]],
    helptext_it    = [[Veloce e capace di saltare per corte distanze o altezze, il Freaker é il costruttore ideale per l'espanzione rapida]],
	helptext_de    = [[Schnell und mit der Möglichkeit ausgestattet über kurze Distanzen oder Höhen zu springen, eignet sich der Freaker als ideale Konstruktionseinheit für rasche Expansion.]],
  },

  defaultmissiontype  = [[Standby]],
  energyMake          = 0.225,
  energyUse           = 0,
  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 2,
  footprintZ          = 2,
  healtime            = [[8]],
  iconType            = [[builder]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[640]],
  mass                = 159,
  maxDamage           = 650,
  maxSlope            = 36,
  maxVelocity         = 2.25,
  maxWaterDepth       = 22,
  metalMake           = 0.225,
  minCloakDistance    = 75,
  movementClass       = [[KBOT2]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
  objectName          = [[behe_coroner.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:VINDIMUZZLE]],
      [[custom:VINDIBACK]],
    },

  },

  showNanoSpray       = false,
  side                = [[CORE]],
  sightDistance       = 375,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[CNSTR]],
  trackOffset         = 0,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[ComTrack]],
  trackWidth          = 22,
  terraformSpeed      = 450,
  turnRate            = 1400,
  upright             = true,
  workerTime          = 9,

  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Freaker]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 750,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 96,
      object           = [[behe_coroner_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 96,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Freaker]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 750,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 96,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 96,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Freaker]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 750,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 48,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 48,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corfast = unitDef })
