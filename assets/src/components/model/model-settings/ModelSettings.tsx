import React, {useEffect,useRef, useState} from 'react';
import {getAccessToken, MODEL_URL} from '../Model';

const ModelSettings: React.FC = () => {
  const iframeRef = useRef<HTMLIFrameElement | null>(null);

  const [reload, setReload] = useState(false);

  useEffect(() => {
    if (!reload) {
      setReload(true);
    }
  }, [reload]);

  return (
    <iframe
      ref={iframeRef}
      src={`${MODEL_URL}?token=${getAccessToken(iframeRef)}&redirect=model_settings`}
      width="100%"
      height="100%"
      title="Model Iframe"
    ></iframe>
  );
};

export default ModelSettings;
