Config = {}

Config.CoreNames = { -- Core Names to split ESX/QB logic 
    QBCore = 'qb-core', -- RENAME if you've renamed qb-core to something else.
    ESX = 'es_extended', -- Same Here
}

-- Inventory settings
Config.InvName = {
    OX = 'ox_inventory' -- IF you're using ox_inventory and have renamed it, you can use this config to easily change all the ox_inventory related exports to the new name.
}

Config.Questions = {
    -- 10% Progress - Initial Setup
    [10] = {
        {
            title = "How do you start the setup process?",
            { question = "Calibrate equipment for precision.", correctAnswer = true },
            { question = "Use equipment as is.", correctAnswer = false },
            { question = "Skip calibration to save time.", correctAnswer = false },
        },
        {
            title = "What safety measures should you take?",
            { question = "Wear protective gear for safety.", correctAnswer = true },
            { question = "Start without any protective gear.", correctAnswer = false },
            { question = "Only use gloves, skipping other gear.", correctAnswer = false },
        },
        {
            title = "How to ensure ingredient quality?",
            { question = "Check for compatibility of all ingredients.", correctAnswer = true },
            { question = "Assume all ingredients are compatible.", correctAnswer = false },
            { question = "Use alternative ingredients available.", correctAnswer = false },
        },
    },
    -- 20% Progress - Mixing Chemicals
    [20] = {
        {
            title = "How to handle chemical mixing?",
            { question = "Adjust the pH balance during mixing.", correctAnswer = true },
            { question = "Ignore pH levels for a faster mix.", correctAnswer = false },
            { question = "Add more solvent to neutralize pH quickly.", correctAnswer = false },
        },
        {
            title = "What's the best approach for chemical formulation?",
            { question = "Follow a precise chemical formula.", correctAnswer = true },
            { question = "Mix based on previous experience.", correctAnswer = false },
            { question = "Experiment with new mixing ratios.", correctAnswer = false },
        },
        {
            title = "What is the optimal temperature for mixing?",
            { question = "Heat chemicals to a specific temperature.", correctAnswer = true },
            { question = "Heat rapidly to highest temperature.", correctAnswer = false },
            { question = "Avoid heating, mix at room temperature.", correctAnswer = false },
        },
    },
    -- 50% Progress - Mid-Process Adjustments
    [50] = {
        {
            title = "How to manage reaction stability?",
            { question = "Stabilize the reaction by adjusting pressure.", correctAnswer = true },
            { question = "Keep pressure high for a faster reaction.", correctAnswer = false },
            { question = "Completely release pressure to avoid risks.", correctAnswer = false },
        },
        {
            title = "What is the role of the condenser at this stage?",
            { question = "Monitor and adjust the condenser flow.", correctAnswer = true },
            { question = "Let the condenser work on auto settings.", correctAnswer = false },
            { question = "Turn off the condenser to save energy.", correctAnswer = false },
        },
        {
            title = "Is adding catalysts necessary?",
            { question = "Carefully add catalysts at this stage.", correctAnswer = true },
            { question = "Skip adding any catalysts.", correctAnswer = false },
            { question = "Add extra catalysts for a quicker process.", correctAnswer = false },
        },
    },
    -- 70% Progress - Near-Completion Checks
    [70] = {
        {
            title = "What quality control is needed?",
            { question = "Conduct a purity test on the sample.", correctAnswer = true },
            { question = "Estimate purity based on appearance.", correctAnswer = false },
            { question = "Ignore purity, focus on quantity.", correctAnswer = false },
        },
        {
            title = "How to ensure product safety?",
            { question = "Check for unwanted chemical residues.", correctAnswer = true },
            { question = "Assume no residues are present.", correctAnswer = false },
            { question = "Dilute the mix to reduce residue impact.", correctAnswer = false },
        },
        {
            title = "How to perfect the crystallization process?",
            { question = "Verify the crystallization process.", correctAnswer = true },
            { question = "Rush crystallization at higher temperatures.", correctAnswer = false },
            { question = "Skip crystallization control.", correctAnswer = false },
        },
    },
    -- 90% Progress - Finalizing
    [90] = {
        {
            title = "How should the final product be handled?",
            { question = "Carefully dry the product to ensure quality.", correctAnswer = true },
            { question = "Speed up drying using high heat.", correctAnswer = false },
            { question = "Package the product while slightly damp.", correctAnswer = false },
        },
        {
            title = "What's the best packaging method?",
            { question = "Weigh and package with precision.", correctAnswer = true },
            { question = "Estimate weights to speed up packaging.", correctAnswer = false },
            { question = "Package in bulk to save time.", correctAnswer = false },
        },
        {
            title = "How to label the finished product?",
            { question = "Label packages with detailed content info.", correctAnswer = true },
            { question = "Use generic labels for all packages.", correctAnswer = false },
            { question = "Skip labeling to avoid identification.", correctAnswer = false },
        },
    },
}

if GetResourceState(Config.CoreNames.QBCore) == 'started' then Framework = 'qb' elseif GetResourceState(Config.CoreNames.ESX) == 'started' then Framework = 'esx' end invState = GetResourceState(Config.InvName.OX)