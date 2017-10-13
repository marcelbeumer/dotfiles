module.exports = {
  config: {
    updateChannel: 'stable',
    fontSize: 12,
    fontFamily: 'Menlo',
    cursorColor: 'rgba(248,28,229,0.8)',
    cursorShape: 'BLOCK',
    cursorBlink: false,
    foregroundColor: '#fff',
    backgroundColor: '#000',
    borderColor: '#333',
    css: '',
    termCSS: '',
    showWindowControls: '',
    padding: '12px 14px',
    colors: {
      black: '#000000',
      red: '#ff0000',
      green: '#33ff00',
      yellow: '#ffff00',
      blue: '#0066ff',
      magenta: '#cc00ff',
      cyan: '#00ffff',
      white: '#d0d0d0',
      lightBlack: '#808080',
      lightRed: '#ff0000',
      lightGreen: '#33ff00',
      lightYellow: '#ffff00',
      lightBlue: '#0066ff',
      lightMagenta: '#cc00ff',
      lightCyan: '#00ffff',
      lightWhite: '#ffffff'
    },
    shell: '',
    shellArgs: ['--login'],
    env: {},
    bell: false,
    copyOnSelect: false,
    confirmQuit: true
  },

  plugins: [
    // 'hyperterm-panda',
    // 'hyperterm-oceanic-next',
    // 'hyperterm-deep-space',
    // 'hyper-monochrome',
    // 'hyper-dracula'
    // 'hyper-ramda',
    // 'hyperterm-atom-dark',
    // 'hyper-solarized-light',
    'hyper-electron-highlighter',
    'hyper-confirm',
    'hyperlayout'
  ],

  localPlugins: [],
  keymaps: {}
};
