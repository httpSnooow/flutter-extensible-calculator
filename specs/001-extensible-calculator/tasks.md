---
description: "Task list for implementing a decoupled and extensible simple calculator in Flutter."
---

# Tasks: Extensible Simple Calculator

**Input**: Design documents from `/specs/001-extensible-calculator/`
**Prerequisites**: plan.md (required), spec.md (required), data-model.md, quickstart.md

**Organization**: Tasks are organized to first build the core engine/registry and then implement UI components that dynamically discover registered operations.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure.

- [x] T001 Create project structure: `lib/src/calculator/domain/operations`, `lib/src/calculator/logic`, `lib/src/calculator/presentation/widgets`
- [x] T002 Add required dependencies (e.g., `provider`) to `pubspec.yaml`
- [x] T003 Configure strict linting in `analysis_options.yaml`

---

## Phase 2: Foundational (Process & Registry)

**Purpose**: Core infrastructure that must be complete before UI or specific operations can be built.

- [x] T004 Define the `Operation` abstract class in `lib/src/calculator/domain/operation.dart`
- [x] T005 Implement `OperationsRegistry` (ChangeNotifier) in `lib/src/calculator/domain/operations_registry.dart`
- [x] T006 [P] Implement `CalculatorState` model in `lib/src/calculator/logic/calculator_state.dart`
- [x] T007 Implement the `CalculatorEngine` logic in `lib/src/calculator/logic/calculator_engine.dart`
- [x] T008 [P] Add unit tests for `CalculatorEngine` and `Registry` in `test/calculator_engine_test.dart`

**Checkpoint**: Foundation ready - calculations and registration work independently of UI.

---

## Phase 3: User Story 1 - Basic Arithmetic (Priority: P1) 🎯 MVP

**Goal**: Implement the core four arithmetic operations using the extension pattern.

**Independent Test**: Verify calculations (5+3=8, 10/2=5) using unit tests and raw engine calls.

### Implementation for User Story 1

- [x] T009 [P] [US1] Implement `AdditionOperation` in `lib/src/calculator/domain/operations/addition.dart`
- [x] T010 [P] [US1] Implement `SubtractionOperation` in `lib/src/calculator/domain/operations/subtraction.dart`
- [x] T011 [P] [US1] Implement `MultiplicationOperation` in `lib/src/calculator/domain/operations/multiplication.dart`
- [x] T012 [P] [US1] Implement `DivisionOperation` in `lib/src/calculator/domain/operations/division.dart`
- [x] T013 [US1] Register basic operations in the startup logic in `lib/main.dart`

**Checkpoint**: Core operations are functional and correctly registered in the engine.

---

## Phase 4: User Story 2 - Dynamic UI (Priority: P2)

**Goal**: Build a calculator UI that automatically displays buttons for every registered operation.

**Independent Test**: Launch the app and verify buttons for +, -, *, / appear based on the registry.

### Implementation for User Story 2

- [x] T014 [P] [US2] Create `CalculatorDisplay` widget (text field) in `lib/src/calculator/presentation/widgets/calculator_display.dart`
- [x] T015 [P] [US2] Create `OperationButton` widget in `lib/src/calculator/presentation/widgets/operation_button.dart`
- [x] T016 [US2] Implement `CalculatorGrid` with dynamic button building in `lib/src/calculator/presentation/widgets/calculator_grid.dart`
- [x] T017 [US2] Build the main `CalculatorScreen` in `lib/src/calculator/presentation/calculator_screen.dart`
- [x] T018 Integrate `CalculatorScreen` as the home widget in `lib/main.dart`

**Checkpoint**: Full end-to-end calculator is functional with dynamic operation buttons.

---

## Phase 5: Polish & Cross-Cutting Concerns

**Purpose**: Verification of extensibility and final refinements.

- [x] T019 [P] Verify dynamic growth by adding `SqrtOperation` as a test case in `lib/src/calculator/domain/operations/sqrt.dart`
- [x] T020 Refine error message UI ("Error" / "NaN") and button styling
- [x] T021 Run `flutter analyze` and ensure zero warnings in production code
- [x] T022 Final manual validation of the P1 and P2 user scenarios

---

## Dependencies & Execution Order

- **Setup (P1)** -> **Foundational (P2)**: MUST establish the registry and engine first.
- **US1 (P3)** -> **US2 (P4)**: Functional operations should exist before building the UI that discovers them.
- **US2 (P4)** -> **Polish (P5)**: UI must be complete before final styling and demo extensions.

---

## Parallel Execution Examples

```bash
# Models and independent logic
Task: "T006 [P] Implement CalculatorState model"
Task: "T008 [P] Add unit tests for CalculatorEngine"

# Operation classes (completely independent)
Task: "T009 [P] [US1] Implement AdditionOperation"
Task: "T010 [P] [US1] Implement SubtractionOperation"
```

## Implementation Strategy

1. **MVP First**: Complete through Phase 3. This gives you a working engine with operations.
2. **Dynamic UI**: Complete Phase 4 to make it usable by a consumer.
3. **Validate Extensibility**: Use T019 to PROVE that the vision component never needed an update to support √.
