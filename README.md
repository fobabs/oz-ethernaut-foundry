# OZ Ethernaut Foundry

Solve OpenZeppelin's [Ethernaut](https://ethernaut.openzeppelin.com/) challenges using [Foundry](https://book.getfoundry.sh/).  
This project provides structured smart contract solutions with automated tests for every level.

## Features

- Smart contract solutions for each Ethernaut level
- Automated tests for every solution
- Organized and easy-to-follow project structure
- Built entirely with Foundry tools

## Getting Started

Follow these steps to set up the project on your local machine.

### Prerequisites

Install the following:

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- [Git](https://git-scm.com/)

### Installation

Clone the repository:

```bash
git clone https://github.com/fobabs/oz-ethernaut-foundry.git
cd oz-ethernaut-foundry
forge install
```

### Running Tests

Run all tests with:

```bash
forge test
```

You can also run tests for a specific level by targeting the test file:

```bash
forge test --match-path test/LEVEL_NAME.t.sol
```

Replace `LEVEL_NAME` with the actual level test filename.

## Project Structure

```
oz-ethernaut-foundry/
│
├── src/            # Solution contracts
│
├── test/           # Test files for each level
│
├── foundry.toml    # Foundry configuration
│
└── README.md       # Project documentation
```

Each level has a solution in `src/` and a matching test in `test/`.

## Contributing

Contributions are welcome.  
You can create issues for bugs or missing levels and open pull requests with improvements.

1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a pull request

Please follow clean coding practices and write tests for any new levels or improvements.

## License

This project is licensed under the MIT License.
