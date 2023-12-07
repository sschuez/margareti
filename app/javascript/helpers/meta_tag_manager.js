export default class MetaTagManager {
  static getContent(metaName) {
    const meta = document.head.querySelector(`meta[name="${metaName}"]`);
    return meta ? meta.content : null;
  }

  static setContent(metaName, value) {
    let meta = document.head.querySelector(`meta[name="${metaName}"]`);
    if (!meta) {
      meta = document.createElement('meta');
      meta.name = metaName;
      document.head.appendChild(meta);
    }
    meta.content = value;
  }
}
