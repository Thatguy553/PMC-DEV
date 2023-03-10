class PMC {
    class factions {
        file = "functions\factions";

        class assignFaction             {};
        class createFaction             {};
        class deleteFaction             {};
        class getFactions               {};
        class renameFaction             {};
    };

    class persistence {
        file = "functions\persistence";

        class getSaveData             {};
        class saveData                 {};
        class setupBases              {};
    };
    
    class bases {
        file = "functions\bases";

        class createBase               {};
        class saveBases                {};
        class getBases                 {};
        class spawnBaseBox             {};
    };

    class config {
        file = "functions\config";

        class saveableObjects           {};
    };
};
